package texcalendar

import (
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/internal/core/calendar"
)

type WeekCalendarLarge struct {
	Week calendar.Week
}

func NewWeekCalendarLarge(week calendar.Week) WeekCalendarLarge {
	return WeekCalendarLarge{Week: week}
}

func (r WeekCalendarLarge) String() string {
	return fmt.Sprintf(`\rotatebox[origin=tr]{90}{\makebox[1.7cm][c]{Week %d}}`, r.Week.Number())
}
