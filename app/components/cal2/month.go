package cal2

import "time"

type Months []*Month
type Month struct {
	Year    *Year
	Quarter *Quarter
	Month   time.Month
	Weeks   Weeks
}

func NewMonth(wd time.Weekday, year *Year, qrtr *Quarter, month time.Month) *Month {
	return &Month{
		Year:    year,
		Quarter: qrtr,
		Month:   month,
		Weeks:   NewWeeksForMonth(wd, year.Number, month),
	}
}
