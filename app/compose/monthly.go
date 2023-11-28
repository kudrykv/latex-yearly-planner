package compose

import (
	"github.com/kudrykv/latex-yearly-planner/app/components/cal"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func Monthly(cfg config.Config, tpls []string) (page.Modules, error) {
	year := cal.NewYear(cfg.WeekStart, cfg.Year, cfg.Example)
	modules := make(page.Modules, 0, 12)

	for _, quarter := range year.Quarters {
		for _, month := range quarter.Months {
			modules = append(modules, page.Module{
				Cfg: cfg,
				Tpl: tpls[0],
				Body: map[string]interface{}{
					"Year":         year,
					"Quarter":      quarter,
					"Month":        month,
					"Breadcrumb":   month.Breadcrumb(),
					"HeadingMOS":   month.HeadingMOS(),
					"SideQuarters": year.SideQuarters(quarter.Number),
					"SideMonths":   year.SideMonths(month.Month),
					"Extra":        month.PrevNext().WithTopRightCorner(cfg.ClearTopRightCorner),
					"Extra2":       extra2(cfg.ClearTopRightCorner, false, false, nil, 0),
				},
			})
		}
	}

	return modules, nil
}
