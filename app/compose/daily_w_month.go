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
	pages := make([]page.Page, 0, 366)
	soy := time.Date(cfg.Year, time.January, 1, 0, 0, 0, 0, time.Local)
	eoy := soy.AddDate(1, 0, 0)

	for today := soy; today.Before(eoy); today = today.AddDate(0, 0, 1) {
		pages = append(pages, page.Page{
			Tpl: cfg.Blocks.DailyWMonth.Tpl,
			Body: DailyWithMonthBody{
				Today: calendar.DayTime{Time: today},
				Month: calendar.NewYearMonth(cfg.Year, today.Month()).Calendar(cfg.WeekStart),
			},
		})
	}

	return pages[:2]
}
