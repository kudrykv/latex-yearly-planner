package compose

import (
	"fmt"
	"strconv"

	"github.com/kudrykv/latex-yearly-planner/app/components/calendar"
	"github.com/kudrykv/latex-yearly-planner/app/components/header"
	"github.com/kudrykv/latex-yearly-planner/app/components/note"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func NotesIndexedV2(cfg config.Config, tpls []string) (page.Modules, error) {
	index := note.NewIndex(cfg.Year, 35, 2)
	modules := make(page.Modules, 0, 1)

	for idx, indexPage := range index.Pages {
		modules = append(modules, page.Module{
			Cfg: cfg,
			Tpl: tpls[0],
			Body: map[string]interface{}{
				"Notes":      indexPage,
				"Breadcrumb": indexPage.Breadcrumb(cfg.Year, idx),
				"Extra":      index.PrevNext(idx),
			},
		})
	}

	for _, notes := range index.Pages {
		for _, nt := range notes {
			modules = append(modules, page.Module{
				Cfg: cfg,
				Tpl: tpls[1],
				Body: map[string]interface{}{
					"Note":       nt,
					"Breadcrumb": nt.Breadcrumb(),
					"Extra":      nt.PrevNext(),
				},
			})
		}
	}

	return modules, nil
}

func HeaderNotesIndexed(cfg config.Config, tpls []string) (page.Modules, error) {
	if len(tpls) != 1 {
		return nil, fmt.Errorf("exppected one tpl, got %d %v", len(tpls), tpls)
	}

	modules := make(page.Modules, 0, 101)
	modules = append(modules, page.Module{
		Cfg: cfg,
		Tpl: tpls[0],
		Body: header.Header{
			Left: header.Items{
				header.NewIntItem(cfg.Year),
				header.NewTextItem("Notes Index").Ref(true),
			},
			Right: header.Items{
				header.NewTextItem("Todos").RefText("Todos Index"),
			},
		},
	})

	for i := 1; i <= 100; i++ {
		right := header.Items{}

		if i > 2 {
			right = append(right, header.NewTextItem("Note "+strconv.Itoa(i-1)))
		}

		if i < 100 {
			right = append(right, header.NewTextItem("Note "+strconv.Itoa(i+1)))
		}

		modules = append(modules, page.Module{
			Cfg: cfg,
			Tpl: tpls[0],
			Body: header.Header{
				Left: header.Items{
					header.NewIntItem(cfg.Year),
					header.NewTextItem("Notes Index"),
					header.NewTextItem("Note " + strconv.Itoa(i)).Ref(true),
				},
				Right: right,
			},
		})
	}

	return modules, nil
}

func HeaderNotesIndexed2(cfg config.Config, tpls []string) (page.Modules, error) {
	if len(tpls) != 1 {
		return nil, fmt.Errorf("exppected one tpl, got %d %v", len(tpls), tpls)
	}

	modules := make(page.Modules, 0, 101)
	modules = append(modules, page.Module{
		Cfg: cfg,
		Tpl: tpls[0],
		Body: map[string]interface{}{
			"Notes": "Notes Index",
			"Cells": header.Items{
				header.NewCellItem("Calendar"),
				header.NewCellItem("To Do").Refer("Todos Index"),
				header.NewCellItem("Notes").Refer("Notes Index").Select(),
			},
			"Months":   MonthsToCellItems(cfg.WeekStart, calendar.NewYearInMonths(cfg.Year).Reverse()),
			"Quarters": QuartersToCellItems(calendar.NewYearInQuarters(cfg.Year).Reverse()),
		},
	})

	for i := 1; i <= 100; i++ {
		modules = append(modules, page.Module{
			Cfg: cfg,
			Tpl: tpls[0],
			Body: map[string]interface{}{
				"Notes": "Note " + strconv.Itoa(i),
				"Cells": header.Items{
					header.NewCellItem("Calendar"),
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
