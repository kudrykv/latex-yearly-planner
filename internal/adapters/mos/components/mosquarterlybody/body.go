package mosquarterlybody

import (
	"bytes"
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosquarterly"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/tex/parbox"
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

	pb := parbox.New(sectionParameters.CalendarsColumnWidth)

	for i, calendarLittle := range texcalendar.NewCalendarsLittle(months, r.calendarsParameters) {
		pb.Add(calendarLittle)

		if i-1 != len(months) {
			pb.Add(entities.VFill)
		}
	}

	buffer.WriteString(pb.Render())

	return buffer.Bytes(), nil
}
