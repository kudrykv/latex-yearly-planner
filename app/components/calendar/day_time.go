package calendar

import (
	"strconv"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/hyper"
)

type DayTime struct {
	time.Time
}

func (t DayTime) Link() string {
	return hyper.Link(t.Format(time.RFC3339), strconv.Itoa(t.Day()))
}

func (t DayTime) RefText() string {
	return t.Format(time.RFC3339)
}
