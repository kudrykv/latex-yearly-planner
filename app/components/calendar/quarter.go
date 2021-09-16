package calendar

import (
	"strconv"
	"time"
)

type Quarter struct {
	Selected   bool
	YearMonths [3]YearMonth
}
type Quarters []Quarter

func NewQuarter(year int, qrtr int) Quarter {
	quarter := Quarter{}
	month := time.Month(qrtr*3 - 2)
	for i := 0; i < 3; i++ {
		quarter.YearMonths[i] = NewYearMonth(year, month)
		month++
	}

	return quarter
}

func (q Quarter) Name() string {
	return "Q" + strconv.Itoa(int(q.YearMonths[2].month/3))
}

func (q Quarter) Hyper() string {
	text := `\hyperlink{` + q.Name() + `}{` + q.Name() + `}`

	if q.Selected {
		text = `\cellcolor{black}{\textcolor{white}{` + q.Name() + `}}`
	}

	return text
}

func NewYearInQuarters(year int) Quarters {
	qrtrs := make(Quarters, 0, 4)

	for qrtr := 1; qrtr <= 4; qrtr++ {
		qrtrs = append(qrtrs, NewQuarter(year, qrtr))
	}

	return qrtrs
}

func (q Quarters) Reverse() Quarters {
	out := make(Quarters, 0, len(q))

	for i := len(q) - 1; i >= 0; i-- {
		out = append(out, q[i])
	}

	return out
}

func (q Quarters) Selected(i int) Quarters {
	q[i-1].Selected = true

	return q
}
