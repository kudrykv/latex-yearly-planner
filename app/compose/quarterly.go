package compose

import (
	"fmt"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/calendar"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func Quarterly(cfg config.Config, tpls []string) (page.Modules, error) {
	if len(tpls) != 1 {
		return nil, fmt.Errorf("exppected one tpl, got %d %v", len(tpls), tpls)
	}

	modules := make(page.Modules, 0, 4)

	for quarter := time.January; quarter <= time.December; quarter += 3 {
		qrtr := make([]calendar.Calendar, 0, 3)

		for month := quarter; month < quarter+3; month++ {
			qrtr = append(qrtr, calendar.NewYearMonth(cfg.Year, month).Calendar(cfg.WeekStart))
		}

		modules = append(modules, page.Module{Cfg: cfg, Tpl: tpls[0], Body: qrtr})
	}

	return modules, nil
}

func makeQuarter(cfg config.Config, quarter int) []calendar.Calendar {
	qrtr := make([]calendar.Calendar, 0, 3)

	for month := time.Month(quarter*3 - 2); month < time.Month(quarter*3+1); month++ {
		qrtr = append(qrtr, calendar.NewYearMonth(cfg.Year, month).Calendar(cfg.WeekStart))
	}

	return qrtr
}
