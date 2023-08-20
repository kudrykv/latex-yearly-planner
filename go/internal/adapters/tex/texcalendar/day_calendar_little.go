package texcalendar

import (
	"github.com/kudrykv/latex-yearly-planner/internal/core/calendar"
	"strconv"
)

type DayCalendarLittle struct {
	Day calendar.Day
}

func NewDayCalendarLittle(day calendar.Day) DayCalendarLittle {
	return DayCalendarLittle{Day: day}
}

func (r DayCalendarLittle) String() string {
	if r.Day.IsZero() {
		return ""
	}

	return strconv.Itoa(r.Day.Day())
}
