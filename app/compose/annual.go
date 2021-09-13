package compose

import (
	"fmt"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/calendar"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func Annual(cfg config.Config, tpls []string) (page.Modules, error) {
	if len(tpls) != 1 {
		return nil, fmt.Errorf("exppected one tpl, got %d %v", len(tpls), tpls)
	}

	return page.Modules{{Cfg: cfg, Tpl: tpls[0], Body: buildQuarters(cfg)}}, nil
}

func buildQuarters(cfg config.Config) [][]calendar.Calendar {
	var quarters [][]calendar.Calendar

	for quarter := time.January; quarter <= time.December; quarter += 3 {
		cals := make([]calendar.Calendar, 0, 3)

		for month := quarter; month < quarter+3; month++ {
			cals = append(cals, calendar.NewYearMonth(cfg.Year, month).Calendar(cfg.WeekStart))
		}

		quarters = append(quarters, cals)
	}

	return quarters
}
