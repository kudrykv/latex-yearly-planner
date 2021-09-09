package calendar

import "time"

type YearMonth struct {
	year  int
	month time.Month
}

func NewYearMonth(year int, month time.Month) YearMonth {
	return YearMonth{
		year:  year,
		month: month,
	}
}

func (m YearMonth) Calendar(wd time.Weekday) Calendar {
	return Calendar{
		month: m.month,
		wd:    wd,
		weeks: MonthWeeklies(wd, m.year, m.month),
	}
}
