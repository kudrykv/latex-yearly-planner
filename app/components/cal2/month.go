package cal2

import (
	"strings"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/hyper"
)

type Months []*Month
type Month struct {
	Year    *Year
	Quarter *Quarter
	Month   time.Month
	Weekday time.Weekday
	Weeks   Weeks
}

func NewMonth(wd time.Weekday, year *Year, qrtr *Quarter, month time.Month) *Month {
	return &Month{
		Year:    year,
		Quarter: qrtr,
		Month:   month,
		Weekday: wd,
		Weeks:   NewWeeksForMonth(wd, year.Number, month),
	}
}

func (m *Month) Link() string {
	return hyper.Link(m.Month.String(), m.Month.String())
}

func (m *Month) WeekHeader() string {
	names := append(make([]string, 0, 8), "W")

	for i := time.Sunday; i < 7; i++ {
		names = append(names, ((m.Weekday + i) % 7).String()[:1])
	}

	return strings.Join(names, " & ")
}
