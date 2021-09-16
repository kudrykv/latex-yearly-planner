package calendar

import (
	"time"
)

type YearMonths []YearMonth
type YearMonth struct {
	Selected bool

	year  int
	month time.Month
}

func NewYearMonth(year int, month time.Month) YearMonth {
	return YearMonth{
		year:  year,
		month: month,
	}
}

func NewYearInMonths(year int) YearMonths {
	yim := make(YearMonths, 0, 12)

	for month := time.January; month <= time.December; month++ {
		yim = append(yim, NewYearMonth(year, month))
	}

	return yim
}

func (m YearMonth) Calendar(wd time.Weekday) Calendar {
	return Calendar{
		month: m.month,
		wd:    wd,
		weeks: MonthWeeklies(wd, m.year, m.month),
	}
}

func (m YearMonth) Hyper() string {
	text := `\hyperlink{` + m.month.String() + `}{` + m.month.String()[:3] + `}`

	if m.Selected {
		text = `\cellcolor{black}{\textcolor{white}{` + m.month.String()[:3] + `}}`
	}

	return text
}

func (m YearMonths) Reverse() YearMonths {
	out := make(YearMonths, 0, len(m))

	for i := len(m) - 1; i >= 0; i-- {
		out = append(out, m[i])
	}

	return out
}

func (m YearMonths) Selected(d DayTime) YearMonths {
	m[d.Month()-1].Selected = true

	return m
}
