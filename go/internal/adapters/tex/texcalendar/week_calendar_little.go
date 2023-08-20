package texcalendar

import (
	"github.com/kudrykv/latex-yearly-planner/internal/core/calendar"
	"strconv"
)

type WeekCalendarLittle struct {
	Week calendar.Week
}

func NewWeekCalendarLittle(week calendar.Week) WeekCalendarLittle {
	return WeekCalendarLittle{Week: week}
}

func (r WeekCalendarLittle) String() string {
	return strconv.Itoa(r.Week.Number())
}
