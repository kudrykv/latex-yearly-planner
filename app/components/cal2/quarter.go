package cal2

import "time"

type Quarters []*Quarter
type Quarter struct {
	Year   *Year
	Number int
	Months Months
}

func NewQuarter(wd time.Weekday, year *Year, qrtr int) *Quarter {
	out := &Quarter{Year: year, Number: qrtr}

	start := time.Month(qrtr*3 - 2)
	end := start + 2

	for month := start; month <= end; month++ {
		out.Months = append(out.Months, NewMonth(wd, year, out, month))
	}

	return out
}
