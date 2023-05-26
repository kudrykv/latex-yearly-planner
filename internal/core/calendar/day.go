package calendar

import "time"

type Day struct {
	Raw   time.Time
	month Month
}

func NewDay(month Month) Day {
	return Day{
		Raw:   time.Date(month.Year, month.Month, 1, 0, 0, 0, 0, time.UTC),
		month: month,
	}
}

func (r Day) Weekday() Weekday {
	return Weekday{Raw: r.Raw.Weekday()}
}

func (r Day) NextDay() Day {
	nextDay := r.Raw.AddDate(0, 0, 1)

	return Day{
		Raw: nextDay,
		month: Month{
			Year:    nextDay.Year(),
			Month:   nextDay.Month(),
			Weekday: r.month.Weekday,
		},
	}
}

func (r Day) IsZero() bool {
	return r.Raw.IsZero()
}

func (r Day) Month() Month {
	return r.month
}

func (r Day) Day() int {
	return r.Raw.Day()
}

func (r Day) WeekNumber() int {
	_, weekNumber := r.Raw.ISOWeek()

	return weekNumber
}

func (r Day) LastInMonth() Day {
	raw := NewDay(r.month).Raw.AddDate(0, 1, -1)

	return Day{Raw: raw, month: r.month}
}

type Days [7]Day

func (r Days) Last() Day {
	return r[6]
}
