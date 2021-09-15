package compose

import (
	"fmt"
	"strconv"

	"github.com/kudrykv/latex-yearly-planner/app/components/calendar"
	"github.com/kudrykv/latex-yearly-planner/app/components/header"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func HeaderMeetingsIndexed2(cfg config.Config, tpls []string) (page.Modules, error) {
	if len(tpls) != 1 {
		return nil, fmt.Errorf("exppected one tpl, got %d %v", len(tpls), tpls)
	}

	modules := make(page.Modules, 0, 101)
	modules = append(modules, page.Module{
		Cfg: cfg,
		Tpl: tpls[0],
		Body: map[string]interface{}{
			"Meetings": "Meetings Index",
			"Cells": header.Items{
				header.NewCellItem("Calendar"),
				header.NewCellItem("Meetings").Refer("Meetings Index").Select(),
				header.NewCellItem("To Do").Refer("Todos Index"),
				header.NewCellItem("Notes").Refer("Notes Index"),
			},
			"Months":   MonthsToCellItems(cfg.WeekStart, calendar.NewYearInMonths(cfg.Year).Reverse()),
			"Quarters": QuartersToCellItems(calendar.NewYearInQuarters(cfg.Year).Reverse()),
		},
	})

	for i := 1; i <= cfg.Layout.Numbers.IndexMeetingNotes; i++ {
		modules = append(modules, page.Module{
			Cfg: cfg,
			Tpl: tpls[0],
			Body: map[string]interface{}{
				"Meetings": `M\#` + strconv.Itoa(i),
				"Cells": header.Items{
					header.NewCellItem("Calendar"),
					header.NewCellItem("Meetings").Refer("Meetings Index"),
					header.NewCellItem("To Do").Refer("Todos Index"),
					header.NewCellItem("Notes").Refer("Notes Index"),
				},
				"Months":   MonthsToCellItems(cfg.WeekStart, calendar.NewYearInMonths(cfg.Year).Reverse()),
				"Quarters": QuartersToCellItems(calendar.NewYearInQuarters(cfg.Year).Reverse()),
			},
		})
	}

	return modules, nil
}
