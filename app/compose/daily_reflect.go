package compose

import (
	"fmt"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/calendar"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func DailyReflect(cfg config.Config, tpls []string) (page.Modules, error) {
	if len(tpls) != 1 {
		return nil, fmt.Errorf("exppected one tpl, got %d %v", len(tpls), tpls)
	}

	modules := make(page.Modules, 0, 366)
	day := calendar.DayTime{Time: time.Date(cfg.Year, time.January, 1, 0, 0, 0, 0, time.Local)}

	for day.Year() == cfg.Year {
		modules = append(modules, page.Module{Cfg: cfg, Tpl: tpls[0], Body: day})

		day = day.AddDate(0, 0, 1)
	}

	return modules, nil
}
