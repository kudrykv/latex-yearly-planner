package compose

import (
	"github.com/kudrykv/latex-yearly-planner/app/components/cal"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

var DailyV2 = DailyStuff("", "")
var DailyReflectV2 = DailyStuff("Reflect", "Reflect")
var DailyNotesV2 = DailyStuff("More", "Notes")

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
								"Breadcrumb":   day.Breadcrumb(prefix, leaf),
								"HeadingMOS":   day.HeadingMOS(prefix, leaf),
								"SideQuarters": year.SideQuarters(day.Quarter()),
								"SideMonths":   year.SideMonths(day.Month()),
								"Extra":        day.PrevNext(prefix),
								"Extra2":       extra2(false, false, week),
							},
						})
					}
				}
			}
		}

		return modules, nil
	}
}
