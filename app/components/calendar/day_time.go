package calendar

import (
	"strconv"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/hyper"
)

type DayTime struct {
	time.Time
}

func (d DayTime) AddDate(years, months, days int) DayTime {
	return DayTime{Time: d.Time.AddDate(years, months, days)}
}

func (t DayTime) Link() string {
	return hyper.Link(t.Format(time.RFC3339), strconv.Itoa(t.Day()))
}

func (t DayTime) RefText() string {
	return t.Format(time.RFC3339)
}
