package compose

import (
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/calendar"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

type DailyWithMonthBody struct {
	Today calendar.DayTime
	Month calendar.Calendar
}

func DailyWMonth(cfg config.Config) []page.Page {
	body := DailyWithMonthBody{
		Today: calendar.DayTime{Time: time.Now()},
		Month: calendar.NewYearMonth(cfg.Year, time.August).Calendar(cfg.WeekStart),
	}

	return []page.Page{{Tpl: cfg.Blocks.DailyWMonth.Tpl, Body: body}}
}
