package mosbodymonthly

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosmonthly"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/tex/texcalendar"
	"github.com/kudrykv/latex-yearly-planner/internal/core/calendar"
)

type Body struct {
	notes              Notes
	calendarParameters texcalendar.CalendarLargeParameters
}

func New(calendarParameters texcalendar.CalendarLargeParameters, notes Notes) Body {
	return Body{
		notes:              notes,
		calendarParameters: calendarParameters,
	}
}

func (r Body) GenerateComponent(_ context.Context, month calendar.Month, _ mosmonthly.SectionParameters) ([]byte, error) {
	cal := texcalendar.NewCalendarLarge(month, r.calendarParameters)

	return []byte(cal.String()), nil
}
