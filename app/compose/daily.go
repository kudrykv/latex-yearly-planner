package compose

import (
	"github.com/kudrykv/latex-yearly-planner/app/components/cal"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

var Daily = DailyStuff("", "")
var DailyReflect = DailyStuff("Reflect", "Reflect 1")
var DailyNotes = DailyStuff("More", "Notes")
var DailyReflectExtended = DailyStuffExtended("Reflect Extended", "Reflect")

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
							},
						})
					}
				}
			}
		}

		return modules, nil
	}
}

func DailyStuffExtended(prefix, leaf string) func(cfg config.Config, tpls []string) (page.Modules, error) {
	return func(cfg config.Config, tpls []string) (page.Modules, error) {
		year := cal.NewYear(cfg.WeekStart, cfg.Year)
		modules := make(page.Modules, 0, 366*cfg.Layout.Numbers.DailyReflectExtra)

		for _, quarter := range year.Quarters {
			for _, month := range quarter.Months {
				for _, week := range month.Weeks {
					for _, day := range week.Days {
						if day.Time.IsZero() {
							continue
						}

						for i := 0; i < cfg.Layout.Numbers.DailyReflectExtra; i++ {
							modules = append(modules, page.Module{
								Cfg: cfg,
								Tpl: tpls[0],
								Body: map[string]interface{}{
									"Year":         year,
									"Quarter":      quarter,
									"Month":        month,
									"Week":         week,
									"Day":          day,
									"PageNum":      i + 1,
									"Breadcrumb":   day.BreadcrumbExtended(prefix, leaf, i+2, cfg.ClearTopRightCorner && len(leaf) > 0),
									"HeadingMOS":   day.HeadingMOS(prefix, leaf),
									"SideQuarters": year.SideQuarters(day.Quarter()),
									"SideMonths":   year.SideMonths(day.Month()),
									"Extra":        day.PrevNextExtended(prefix, i, cfg.Layout.Numbers.DailyReflectExtra).WithTopRightCorner(cfg.ClearTopRightCorner),
									"Extra2":       extra2(cfg.ClearTopRightCorner, false, false, week, 0),
								},
							})
						}
					}
				}
			}
		}

		return modules, nil
	}
}
