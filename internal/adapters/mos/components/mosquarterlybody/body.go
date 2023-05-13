package mosquarterlybody

import (
	"bytes"
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosquarterly"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/tex/minipages"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/tex/spacers"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/tex/texcalendar"
	"github.com/kudrykv/latex-yearly-planner/internal/core/calendar"
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

	mp := minipages.New(minipages.Parameters{
		Width:  sectionParameters.CalendarsColumnWidth,
		Height: sectionParameters.CalendarsColumnHeight,
	})

	for i, calendarLittle := range texcalendar.NewCalendarsLittle(months, r.calendarsParameters) {
		mp.Add(calendarLittle)

		if i-1 != len(months) {
			mp.AddString("\n\n")
			mp.Add(spacers.NewVSpace(sectionParameters.CalendarsVerticalSpacing))
		}
	}

	buffer.WriteString(mp.Render())

	return buffer.Bytes(), nil
}