package texcalendar

import (
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/tex/tabularx"
	"github.com/kudrykv/latex-yearly-planner/internal/core/calendar"
)

type CalendarsLittle []CalendarLittle

func NewCalendarsLittle(months calendar.Months, parameters CalendarLittleParameters) CalendarsLittle {
	if len(months) == 0 {
		return nil
	}

	calendars := make(CalendarsLittle, 0, len(months))

	for _, month := range months {
		calendars = append(calendars, NewCalendarLittle(month, parameters))
	}

	return calendars
}

type CalendarLittle struct {
	Month      calendar.Month
	Parameters CalendarLittleParameters
}

type CalendarLittleParameters struct{}

func NewCalendarLittle(month calendar.Month, parameters CalendarLittleParameters) CalendarLittle {
	return CalendarLittle{
		Month:      month,
		Parameters: parameters,
	}
}

func (r CalendarLittle) String() string {
	tabular := tabularx.New(LineWidth{})
	tabular.SetHeaderName(r.Month.Name())

	//    MONTH NAME
	// # | M | T | W | T | F | S | S |
	// 1 | _ | _ | _ | _ | 1 | 2 | 3 |
	// 2 | 4 | 5 | 6 | 7 | 8 | 9 | 10|
	// ...
	// 5 | 28| 29| 30| 31| _ | _ | _ |
	// ^                               ^--\
	//  \ week number; can go to the right \
	// or be disabled at all

	r.Month.Weeks()

	tabular.AddRow(tabularx.Cell{Text: r.Month.Month})

	return tabular.Render()
}

type LineWidth struct{}

func (r LineWidth) String() string {
	return `\linewidth`
}
