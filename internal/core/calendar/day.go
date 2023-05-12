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
	return Day{Raw: r.Raw.AddDate(0, 0, 1)}
}

func (r Day) IsZero() bool {
	return r.Raw.IsZero()
}

func (r Day) Month() Month {
	return r.month
}

type Days [7]Day

func (r Days) Last() Day {
	return r[6]
}
