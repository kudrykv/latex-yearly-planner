package cal2

import "time"

type Weeks []*Week
type Week struct {
	Days [7]Day
}

func NewWeeksForMonth(wd time.Weekday, year int, month time.Month) Weeks {
	ptr := time.Date(year, month, 1, 0, 0, 0, 0, time.Local)
	weekday := ptr.Weekday()
	shift := (7 + weekday - wd) % 7

	week := &Week{}

	for i := shift; i < 7; i++ {
		week.Days[i] = Day{Time: ptr}
		ptr = ptr.AddDate(0, 0, 1)
	}

	weeks := Weeks{}
	weeks = append(weeks, week)

	for ptr.Month() == month {
		week = &Week{}

		for i := 0; i < 7; i++ {
			if ptr.Month() != month {
				break
			}

			week.Days[i] = Day{ptr}
			ptr = ptr.AddDate(0, 0, 1)
		}

		weeks = append(weeks, week)
	}

	return weeks
}

func (w *Week) WeekNumber() int {
	_, wn := w.Days[0].Time.ISOWeek()

	for _, t := range w.Days {
		if _, cwn := t.Time.ISOWeek(); !t.Time.IsZero() && cwn != wn {
			return cwn
		}
	}

	return wn
}
