package mos

import (
	"github.com/kudrykv/latex-yearly-planner/internal/core/calendar"
)

type Parameters struct {
	Start           calendar.Month
	End             calendar.Month
	Weekday         calendar.Weekday
	WithWeekNumbers bool
	AMPMFormat      bool
}
