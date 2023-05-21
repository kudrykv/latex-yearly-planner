package texcalendar

import (
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/tex/tabularxes"
	"github.com/kudrykv/latex-yearly-planner/internal/core/calendar"
	"github.com/kudrykv/latex-yearly-planner/internal/core/entities"
)

type CalendarLarge struct {
	Month      calendar.Month
	Parameters CalendarLargeParameters
}

type CalendarLargeParameters struct {
	ShowWeekNumbers     bool
	WeekNumberPlacement entities.Placement
}

func NewCalendarLarge(month calendar.Month, parameters CalendarLargeParameters) CalendarLarge {
	return CalendarLarge{
		Month:      month,
		Parameters: parameters,
	}
}

func (r CalendarLarge) String() string {
	table := tabularxes.New(entities.LineWidth)

	table.SetHeaderName(r.Month.Name())

	table.AddRow(r.makeWeekdays()...)

	for _, week := range r.Month.Weeks() {
		cells := make([]tabularxes.Cell, 0, len(week.Days)+1)

		for _, day := range week.Days {
			cells = append(cells, tabularxes.Cell{Text: NewDayCalendarLarge(day)})
		}

		if r.Parameters.ShowWeekNumbers {
			if r.Parameters.WeekNumberPlacement == entities.PlacementRight {
				cells = append(cells, tabularxes.Cell{Text: NewWeekCalendarLarge(week)})
			} else {
				cells = append([]tabularxes.Cell{{Text: NewWeekCalendarLarge(week)}}, cells...)
			}
		}

		table.AddRow(cells...)
	}

	return table.Render()
}

func (r CalendarLarge) makeWeekdays() tabularxes.Cells {
	cells := make(tabularxes.Cells, 0, 7)

	weekday := r.Month.Weekday
	for i := 0; i < 7; i++ {
		cells = append(cells, tabularxes.Cell{Text: NewWeekdayCalendarLarge(weekday)})
		weekday = weekday.Next()
	}

	if r.Parameters.ShowWeekNumbers {
		if r.Parameters.WeekNumberPlacement == entities.PlacementRight {
			cells = append(cells, tabularxes.Cell{Text: NewWeekNameCalendarLarge()})
		} else {
			cells = append([]tabularxes.Cell{{Text: NewWeekNameCalendarLarge()}}, cells...)
		}
	}

	return cells
}
