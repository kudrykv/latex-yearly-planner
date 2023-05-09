package texcalendar

import "github.com/kudrykv/latex-yearly-planner/internal/core/calendar"

type CalendarsLittle []CalendarLittle

func NewCalendarsLittle(months calendar.Months) CalendarsLittle {
	if len(months) == 0 {
		return nil
	}

	calendars := make(CalendarsLittle, 0, len(months))

	for _, month := range months {
		calendars = append(calendars, NewCalendarLittle(month))
	}

	return calendars
}

type CalendarLittle struct {
	Month calendar.Month
}

func (r CalendarLittle) String() string {
	return r.Month.Name()
}

func NewCalendarLittle(month calendar.Month) CalendarLittle {
	return CalendarLittle{Month: month}
}
