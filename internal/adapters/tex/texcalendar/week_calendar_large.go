package texcalendar

import (
	"github.com/kudrykv/latex-yearly-planner/internal/core/calendar"
	"strconv"
)

type WeekCalendarLarge struct {
	Week calendar.Week
}

func NewWeekCalendarLarge(week calendar.Week) WeekCalendarLarge {
	return WeekCalendarLarge{Week: week}
}

func (r WeekCalendarLarge) String() string {
	return strconv.Itoa(r.Week.Number())
}
