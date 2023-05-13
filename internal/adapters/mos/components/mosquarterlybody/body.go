package mosquarterlybody

import (
	"bytes"
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosquarterly"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/tex/minipages"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/tex/spacers"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/tex/texcalendar"
	"github.com/kudrykv/latex-yearly-planner/internal/core/calendar"
	"github.com/kudrykv/latex-yearly-planner/internal/core/entities"
)

type Body struct {
	calendarsParameters texcalendar.CalendarLittleParameters
}

func New(calendarsParameters texcalendar.CalendarLittleParameters) Body {
	return Body{
		calendarsParameters: calendarsParameters,
	}
}

func (r Body) GenerateComponent(
	_ context.Context, months calendar.Months, sectionParameters mosquarterly.SectionParameters,
) ([]byte, error) {
	buffer := bytes.NewBuffer(nil)

	calendarsColumn := minipages.New(minipages.Parameters{
		Width:  sectionParameters.CalendarsColumnWidth,
		Height: sectionParameters.ColumnHeight,
	})

	for i, calendarLittle := range texcalendar.NewCalendarsLittle(months, r.calendarsParameters) {
		calendarsColumn.Add(calendarLittle)

		if i-1 != len(months) {
			calendarsColumn.AddString("\n\n")
			calendarsColumn.Add(spacers.NewVSpace(sectionParameters.CalendarsVerticalSpacing))
		}
	}

	notesColumn := minipages.New(minipages.Parameters{
		Width:  sectionParameters.NotesColumnWidth,
		Height: sectionParameters.ColumnHeight,
	})

	notesColumn.AddString("future notes here")

	if sectionParameters.CalendarsColumn == entities.PlacementRight {
		buffer.WriteString(notesColumn.Render())
		buffer.WriteString(spacers.NewHSpace(sectionParameters.ColumnSpacing).String())
		buffer.WriteString(calendarsColumn.Render())
	} else {
		buffer.WriteString(calendarsColumn.Render())
		buffer.WriteString(spacers.NewHSpace(sectionParameters.ColumnSpacing).String())
		buffer.WriteString(notesColumn.Render())
	}

	return buffer.Bytes(), nil
}
