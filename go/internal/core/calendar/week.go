package calendar

type Week struct {
	Days Days
}

func NewWeeksOfMonth(month Month) Weeks {
	var ok bool
	week := NewFirstWeek(month)
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

func NewFirstWeek(month Month) Week {
	day := month.FirstDay()
	weekday := day.Weekday()
	shift := weekday.RightDistanceTo(month.Weekday)

	days := Days{}

	for i := shift; i < 7; i++ {
		days[i] = day
		day = day.NextDay()
	}

	return Week{days}
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

func (r Week) Number() int {
	for i := 6; i >= 0; i-- {
		if !r.Days[i].IsZero() {
			return r.Days[i].WeekNumber()
		}
	}

	return -1
}

func (r Week) LastDay() Day {
	for i := 6; i >= 0; i-- {
		if !r.Days[i].IsZero() {
			return r.Days[i]
		}
	}

	return Day{}
}

type Weeks []Week
