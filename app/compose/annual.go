package compose

import (
	"github.com/kudrykv/latex-yearly-planner/app/components/cal"
	"github.com/kudrykv/latex-yearly-planner/app/components/header"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func Annual(cfg config.Config, tpls []string) (page.Modules, error) {
	year := cal.NewYear(cfg.WeekStart, cfg.Year)

	return page.Modules{{
		Cfg: cfg,
		Tpl: tpls[0],
		Body: map[string]interface{}{
			"Year":         year,
			"Breadcrumb":   year.Breadcrumb(),
			"HeadingMOS":   year.HeadingMOS(),
			"SideQuarters": year.SideQuarters(0),
			"SideMonths":   year.SideMonths(0),
			"Extra":        header.Items{header.NewTextItem("Notes").RefText("Notes Index")},
			"Extra2":       extra2(true, false, nil),
		},
	}}, nil
}

func extra2(sel1, sel2 bool, week *cal.Week) header.Items {
	items := make(header.Items, 0, 3)

	if week != nil {
		items = append(items, header.NewCellItem(week.Name()))
	}

	items = append(
		items,
		header.NewCellItem("Calendar").Selected(sel1),
		header.NewCellItem("Notes").Refer("Notes Index").Selected(sel2),
	)

	return items
}
