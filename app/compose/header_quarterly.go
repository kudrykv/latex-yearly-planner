package compose

import (
	"fmt"

	"github.com/kudrykv/latex-yearly-planner/app/components/calendar"
	"github.com/kudrykv/latex-yearly-planner/app/components/header"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func HeaderQuarterly(cfg config.Config, tpls []string) (page.Modules, error) {
	if len(tpls) != 1 {
		return nil, fmt.Errorf("exppected one tpl, got %d %v", len(tpls), tpls)
	}

	modules := make(page.Modules, 0, 4)
	hRight := header.Items{header.NewTextItem("Notes"), header.NewTextItem("Todos")}

	for quarter := 1; quarter <= 4; quarter++ {
		hQrtrs := header.NewItemsGroup(
			header.NewTextItem("Q1").Bold(quarter == 1).Ref(quarter == 1),
			header.NewTextItem("Q2").Bold(quarter == 2).Ref(quarter == 2),
			header.NewTextItem("Q3").Bold(quarter == 3).Ref(quarter == 3),
			header.NewTextItem("Q4").Bold(quarter == 4).Ref(quarter == 4),
		)

		modules = append(modules, page.Module{
			Cfg: cfg,
			Tpl: tpls[0],
			Body: header.Header{
				Left:  header.Items{header.NewIntItem(cfg.Year), hQrtrs},
				Right: hRight,
			},
		})
	}

	return modules, nil
}

func HeaderQuarterly2(cfg config.Config, tpls []string) (page.Modules, error) {
	if len(tpls) != 1 {
		return nil, fmt.Errorf("exppected one tpl, got %d %v", len(tpls), tpls)
	}

	modules := make(page.Modules, 0, 4)

	for i := 1; i <= 4; i++ {
		modules = append(modules, page.Module{
			Cfg: cfg,
			Tpl: tpls[0],
			Body: map[string]interface{}{
				"Quarter":  i,
				"Months":   calendar.NewYearInMonths(cfg.Year).Reverse(),
				"Quarters": calendar.NewYearInQuarters(cfg.Year).Selected(i).Reverse(),
			},
		})
	}

	return modules, nil
}
