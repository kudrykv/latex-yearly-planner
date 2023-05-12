package calendar

type Week struct {
	Days Days
}

func NewWeeksOfMonth(month Month) Weeks {
	day := month.FirstDay()
	weekday := day.Weekday()
	shift := weekday.RightDistanceTo(month.Weekday)

	days := Days{}

	for i := shift; i < 7; i++ {
		days[i] = day
		day = day.NextDay()
	}

	var ok bool
	week := Week{days}
	weeks := Weeks{week}

	for {
		week, ok = week.NextWeekInMonth()
		if !ok {
			break
		}

		weeks = append(weeks, week)
	}

	return weeks
}

func (r Week) NextWeekInMonth() (Week, bool) {
	weekLastDay := r.Days.Last()
	if weekLastDay.IsZero() {
		return Week{}, false
	}

	nextWeekFirstDay := weekLastDay.NextDay()
	if weekLastDay.Month() != nextWeekFirstDay.Month() {
		return Week{}, false
	}

	week := r.Next()
	for i := 0; i < 7; i++ {
		if week.Days[i].Month() != weekLastDay.Month() {
			week.Days[i] = Day{}
		}
	}

	return week, true
}

func (r Week) Next() Week {
	days := Days{}

	day := r.Days.Last()

	for i := 0; i < 7; i++ {
		day = day.NextDay()
		days[i] = day
	}

	return Week{Days: days}
}

type Weeks []Week
