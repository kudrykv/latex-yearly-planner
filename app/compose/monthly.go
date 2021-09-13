package compose

import (
	"fmt"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/calendar"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func Monthly(cfg config.Config, tpls []string) (page.Modules, error) {
	if len(tpls) != 1 {
		return nil, fmt.Errorf("exppected one tpl, got %d %v", len(tpls), tpls)
	}

	modules := make(page.Modules, 0, 12)

	for month := time.January; month <= time.December; month++ {
		modules = append(modules, page.Module{
			Cfg:  cfg,
			Tpl:  tpls[0],
			Body: calendar.NewYearMonth(cfg.Year, month).Calendar(cfg.WeekStart),
		})
	}

	return modules, nil
}
