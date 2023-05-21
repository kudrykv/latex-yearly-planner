package texcalendar

import (
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
	return r.Month.Name()
}
