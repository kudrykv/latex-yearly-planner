package texcalendar

import (
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/tex/tabularxes"
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
	Width               entities.Length
}

func NewCalendarLittle(month calendar.Month, parameters CalendarLittleParameters) CalendarLittle {
	return CalendarLittle{
		Month:      month,
		Parameters: parameters,
	}
}

func (r CalendarLittle) String() string {
	tabular := tabularxes.New(r.makeWidth())
	tabular.SetHeaderName(r.Month.Name())

	tabular.AddRow(r.makeWeekdays()...)

	if r.Parameters.ShowWeekNumbers {
		if r.Parameters.WeekNumberPlacement == entities.PlacementRight {
			tabular.SetColumnFormat("*{7}{Y}|Y")
		} else {
			tabular.SetColumnFormat("Y|*{7}{Y}")
		}
	} else {
		tabular.SetColumnFormat("*{7}{Y}")
	}

	for _, week := range r.Month.Weeks() {
		cells := make([]tabularxes.Cell, 0, len(week.Days)+1)

		for _, day := range week.Days {
			cells = append(cells, tabularxes.Cell{Text: NewDayCalendarLittle(day)})
		}

		if r.Parameters.ShowWeekNumbers {
			if r.Parameters.WeekNumberPlacement == entities.PlacementRight {
				cells = append(cells, tabularxes.Cell{Text: NewWeekCalendarLittle(week)})
			} else {
				cells = append([]tabularxes.Cell{{Text: NewWeekCalendarLittle(week)}}, cells...)
			}
		}

		tabular.AddRow(cells...)
	}

	return tabular.Render()
}

func (r CalendarLittle) makeWeekdays() tabularxes.Cells {
	cells := make(tabularxes.Cells, 0, 7)

	weekday := r.Month.Weekday
	for i := 0; i < 7; i++ {
		cells = append(cells, tabularxes.Cell{Text: NewWeekdayCalendarLittle(weekday)})
		weekday = weekday.Next()
	}

	if r.Parameters.ShowWeekNumbers && r.Parameters.WeekNumberPlacement == entities.PlacementRight {
		cells = append(cells, tabularxes.Cell{Text: NewWeekNameCalendarLittle()})
	} else {
		cells = append([]tabularxes.Cell{{Text: NewWeekNameCalendarLittle()}}, cells...)
	}

	return cells
}

func (r CalendarLittle) makeWidth() fmt.Stringer {
	if r.Parameters.Width.IsZero() {
		return entities.LineWidth
	}

	return r.Parameters.Width
}