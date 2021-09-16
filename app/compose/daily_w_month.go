package compose

import (
	"fmt"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/calendar"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func DailyWMonth(cfg config.Config, tpls []string) (page.Modules, error) {
	if len(tpls) != 1 {
		return nil, fmt.Errorf("exppected one tpl, got %d %v", len(tpls), tpls)
	}

	modules := make(page.Modules, 0, 366)
	soy := time.Date(cfg.Year, time.January, 1, 0, 0, 0, 0, time.Local)
	eoy := soy.AddDate(1, 0, 0)

	for today := soy; today.Before(eoy); today = today.AddDate(0, 0, 1) {
		modules = append(modules, page.Module{
			Cfg: cfg,
			Tpl: tpls[0],
			Body: map[string]interface{}{
				"Today": calendar.DayTime{Time: today},
				"Month": calendar.NewYearMonth(cfg.Year, today.Month()).Calendar(cfg.WeekStart),
			},
		})
	}

	return modules, nil
}
