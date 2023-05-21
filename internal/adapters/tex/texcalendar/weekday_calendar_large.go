package texcalendar

import "github.com/kudrykv/latex-yearly-planner/internal/core/calendar"

type WeekdayCalendarLarge struct {
	Weekday calendar.Weekday
}

func NewWeekdayCalendarLarge(weekday calendar.Weekday) WeekdayCalendarLarge {
	return WeekdayCalendarLarge{Weekday: weekday}
}

func (r WeekdayCalendarLarge) String() string {
	return r.Weekday.String()[:3]
}
