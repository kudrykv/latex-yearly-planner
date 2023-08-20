package texcalendar

import "github.com/kudrykv/latex-yearly-planner/internal/core/calendar"

type WeekdayCalendarLittle struct {
	Weekday calendar.Weekday
}

func NewWeekdayCalendarLittle(weekday calendar.Weekday) WeekdayCalendarLittle {
	return WeekdayCalendarLittle{Weekday: weekday}
}

func (r WeekdayCalendarLittle) String() string {
	return r.Weekday.String()[:1]
}
