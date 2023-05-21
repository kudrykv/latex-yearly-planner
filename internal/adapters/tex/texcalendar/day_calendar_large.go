package texcalendar

import (
	"github.com/kudrykv/latex-yearly-planner/internal/core/calendar"
	"strconv"
)

type DayCalendarLarge struct {
	Day calendar.Day
}

func NewDayCalendarLarge(day calendar.Day) DayCalendarLarge {
	return DayCalendarLarge{Day: day}
}

func (r DayCalendarLarge) String() string {
	if r.Day.IsZero() {
		return ""
	}

	return strconv.Itoa(r.Day.Day())
}
