package cal2

import "time"

type Years []*Year
type Year struct {
	Number   int
	Quarters Quarters
}

func NewYear(wd time.Weekday, year int) *Year {
	out := &Year{Number: year}

	for q := 1; q <= 4; q++ {
		out.Quarters = append(out.Quarters, NewQuarter(wd, out, q))
	}

	return out
}
