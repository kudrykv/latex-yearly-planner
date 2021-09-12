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

func (d DayTime) Link() string {
	return hyper.Link(d.RefText(), strconv.Itoa(d.Day()))
}

func (d DayTime) RefText() string {
	return d.Format(time.RFC3339)
}
