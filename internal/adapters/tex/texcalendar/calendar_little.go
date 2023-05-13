package texcalendar

import (
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/tex/tabularx"
	"github.com/kudrykv/latex-yearly-planner/internal/core/calendar"
	"github.com/kudrykv/latex-yearly-planner/internal/core/entities"
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

type CalendarLittleParameters struct {
	ShowWeekNumbers     bool
	WeekNumberPlacement entities.Placement
}

func NewCalendarLittle(month calendar.Month, parameters CalendarLittleParameters) CalendarLittle {
	return CalendarLittle{
		Month:      month,
		Parameters: parameters,
	}
}

func (r CalendarLittle) String() string {
	tabular := tabularx.New(LineWidth{})
	tabular.SetHeaderName(r.Month.Name())

	tabular.AddRow(r.makeWeekdays()...)

	for _, week := range r.Month.Weeks() {
		cells := make([]tabularx.Cell, 0, len(week.Days)+1)

		for _, day := range week.Days {
			cells = append(cells, tabularx.Cell{Text: NewDayCalendarLittle(day)})
		}

		if r.Parameters.ShowWeekNumbers {
			if r.Parameters.WeekNumberPlacement == entities.PlacementRight {
				cells = append(cells, tabularx.Cell{Text: NewWeekCalendarLittle(week)})
			} else {
				cells = append([]tabularx.Cell{{Text: NewWeekCalendarLittle(week)}}, cells...)
			}
		}

		tabular.AddRow(cells...)
	}

	return tabular.Render()
}

func (r CalendarLittle) makeWeekdays() tabularx.Cells {
	cells := make(tabularx.Cells, 0, 7)

	weekday := r.Month.Weekday
	for i := 0; i < 7; i++ {
		cells = append(cells, tabularx.Cell{Text: NewWeekdayCalendarLittle(weekday)})
		weekday = weekday.Next()
	}

	if r.Parameters.ShowWeekNumbers && r.Parameters.WeekNumberPlacement == entities.PlacementRight {
		cells = append(cells, tabularx.Cell{Text: NewWeekNameCalendarLittle()})
	} else {
		cells = append([]tabularx.Cell{{Text: NewWeekNameCalendarLittle()}}, cells...)
	}

	return cells
}

type LineWidth struct{}

func (r LineWidth) String() string {
	return `\linewidth`
}
