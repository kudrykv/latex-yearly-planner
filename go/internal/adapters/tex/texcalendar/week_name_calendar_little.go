package texcalendar

type WeekNameCalendarLittle struct{}

func NewWeekNameCalendarLittle() WeekNameCalendarLittle {
	return WeekNameCalendarLittle{}
}

func (r WeekNameCalendarLittle) String() string {
	return `W`
}
