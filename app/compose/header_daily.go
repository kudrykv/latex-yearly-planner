package compose

import (
	"fmt"
	"math"
	"strconv"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/cal2"
	"github.com/kudrykv/latex-yearly-planner/app/components/calendar"
	"github.com/kudrykv/latex-yearly-planner/app/components/header"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

var DailyV2 = DailyStuff("", "")
var DailyReflectV2 = DailyStuff("Reflect", "Reflect")
var DailyNotesV2 = DailyStuff("More", "Notes")

func DailyStuff(prefix, leaf string) func(cfg config.Config, tpls []string) (page.Modules, error) {
	return func(cfg config.Config, tpls []string) (page.Modules, error) {
		year := cal2.NewYear(cfg.WeekStart, cfg.Year)
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
								"HeadingMOS":   day.HeadingMOS(),
								"SideQuarters": year.SideQuarters(day.Quarter()),
								"SideMonths":   year.SideMonths(day.Month()),
								"Extra":        day.PrevNext(prefix),
								"Extra2":       extra2(false),
							},
						})
					}
				}
			}
		}

		return modules, nil
	}
}

func HeaderDaily(cfg config.Config, tpls []string) (page.Modules, error) {
	if len(tpls) != 1 {
		return nil, fmt.Errorf("exppected one tpl, got %d %v", len(tpls), tpls)
	}

	modules := make(page.Modules, 0, 366)
	day := calendar.DayTime{Time: time.Date(cfg.Year, time.January, 1, 0, 0, 0, 0, time.Local)}

	for day.Year() == cfg.Year {
		right := header.Items{}
		prefix := ""
		_, weekNum := day.ISOWeek()

		if weekNum > 50 && day.Month() == time.January {
			prefix = "fw"
		}

		left := header.Items{
			header.NewIntItem(cfg.Year),
			header.NewTextItem("Q" + strconv.Itoa(int(math.Ceil(float64(day.Month())/3.)))),
			header.NewMonthItem(day.Month()),
			header.NewTextItem("Week " + strconv.Itoa(weekNum)).RefPrefix(prefix),
			header.NewTimeItem(day).SetLayout("Monday, 2").Ref(),
		}

		if day.Month() != time.January || day.Day() != 1 {
			right = append(right, header.NewTimeItem(day.AddDate(0, 0, -1)).SetLayout("Mon, 2"))
		}

		if day.Month() != time.December || day.Day() != 31 {
			right = append(right, header.NewTimeItem(day.AddDate(0, 0, 1)).SetLayout("Mon, 2"))
		}

		modules = append(modules, page.Module{
			Cfg:  cfg,
			Tpl:  tpls[0],
			Body: header.Header{Left: left, Right: right},
		})

		day = day.AddDate(0, 0, 1)
	}

	return modules, nil
}

func HeaderDaily2(cfg config.Config, tpls []string) (page.Modules, error) {
	if len(tpls) != 1 {
		return nil, fmt.Errorf("exppected one tpl, got %d %v", len(tpls), tpls)
	}

	modules := make(page.Modules, 0, 366)
	day := calendar.DayTime{Time: time.Date(cfg.Year, time.January, 1, 0, 0, 0, 0, time.Local)}

	for day.Year() == cfg.Year {
		modules = append(modules, page.Module{
			Cfg: cfg,
			Tpl: tpls[0],
			Body: map[string]interface{}{
				"Today": day,
				"Date":  day,
				"Cells": header.Items{
					header.NewCellItem("Calendar"),
					header.NewCellItem("To Do").Refer("Todos Index"),
					header.NewCellItem("Notes").Refer("Notes Index"),
				},
				"Months":   MonthsToCellItems(cfg.WeekStart, calendar.NewYearInMonths(cfg.Year).Selected(day).Reverse()),
				"Quarters": QuartersToCellItems(calendar.NewYearInQuarters(cfg.Year).Reverse()),
			},
		})

		day = day.AddDate(0, 0, 1)
	}

	return modules, nil
}
