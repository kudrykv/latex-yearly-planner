package mosmonthlybody

import (
	"context"
	"fmt"
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

func (r Body) GenerateComponent(_ context.Context, month calendar.Month, parameters mosmonthly.SectionParameters) ([]byte, error) {
	cal := texcalendar.NewCalendarLarge(month, r.calendarParameters)
	gap := fmt.Sprintf(`\vspace{%s}`, parameters.Gap)
	notes := r.notes.Render(parameters.NotesWidth, parameters.NotesHeight)

	return []byte(cal.String() + "\n\n" + gap + "\n\n" + notes), nil
}
