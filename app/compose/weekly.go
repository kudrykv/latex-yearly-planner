package compose

import (
	"fmt"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/calendar"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func Weekly(cfg config.Config, tpls []string) (page.Modules, error) {
	if len(tpls) != 1 {
		return nil, fmt.Errorf("exppected one tpl, got %d %v", len(tpls), tpls)
	}

	sow := pickUpStartWeekForTheYear(cfg.Year, cfg.WeekStart)
	modules := make(page.Modules, 0, 53)

	yearInWeeks := calendar.FillWeekly(sow).FillYear()
	for _, weekly := range yearInWeeks {
		modules = append(modules, page.Module{Cfg: cfg, Tpl: tpls[0], Body: weekly})
	}

	return modules, nil
}

func pickUpStartWeekForTheYear(year int, weekStart time.Weekday) calendar.DayTime {
	soy := time.Date(year, time.January, 1, 0, 0, 0, 0, time.Local)
	sow := soy

	for sow.Weekday() != weekStart {
		sow = sow.AddDate(0, 0, 1)
	}

	if sow.Year() == year && sow.Day() > 1 {
		sow = sow.AddDate(0, 0, -7)
	}

	return calendar.DayTime{Time: sow}
}
