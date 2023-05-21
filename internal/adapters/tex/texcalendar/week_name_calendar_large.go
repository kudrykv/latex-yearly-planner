package texcalendar

type WeekNameCalendarLarge struct{}

func NewWeekNameCalendarLarge() WeekNameCalendarLarge {
	return WeekNameCalendarLarge{}
}

func (r WeekNameCalendarLarge) String() string {
	return `W`
}
