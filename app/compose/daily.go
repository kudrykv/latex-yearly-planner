package compose

import (
	"github.com/kudrykv/latex-yearly-planner/app/components/cal"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

var Daily = DailyStuff("", "")
var DailyReflect = DailyStuff("Reflect", "Reflect")
var DailyNotes = DailyStuff("More", "Notes")

func DailyStuff(prefix, leaf string) func(cfg config.Config, tpls []string) (page.Modules, error) {
	return func(cfg config.Config, tpls []string) (page.Modules, error) {
		year := cal.NewYear(cfg.WeekStart, cfg.Year)
		modules := make(page.Modules, 0, 366)

		for _, quarter := range year.Quarters {
			for _, month := range quarter.Months {
				for _, week := range month.Weeks {
					for _, day := range week.Days {
						if day.Time.IsZero() {
							continue
						}

						modules = append(modules, page.Module{
							Cfg: cfg,
							Tpl: tpls[0],
							Body: map[string]interface{}{
								"Year":         year,
								"Quarter":      quarter,
								"Month":        month,
								"Week":         week,
								"Day":          day,
								"Breadcrumb":   day.Breadcrumb(prefix, leaf, cfg.ClearTopRightCorner && len(leaf) > 0),
								"HeadingMOS":   day.HeadingMOS(prefix, leaf),
								"SideQuarters": year.SideQuarters(day.Quarter()),
								"SideMonths":   year.SideMonths(day.Month()),
								"Extra":        day.PrevNext(prefix).WithTopRightCorner(cfg.ClearTopRightCorner),
								"Extra2":       extra2(cfg.ClearTopRightCorner, false, false, week, 0),
								"Events":       day.GetEvents(),
							},
						})
					}
				}
			}
		}

		return modules, nil
	}
}
