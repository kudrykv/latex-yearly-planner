package compose

import (
	"fmt"
	"math"
	"strconv"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/calendar"
	"github.com/kudrykv/latex-yearly-planner/app/components/header"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func HeaderDailyReflect(cfg config.Config, tpls []string) (page.Modules, error) {
	if len(tpls) != 1 {
		return nil, fmt.Errorf("exppected one tpl, got %d %v", len(tpls), tpls)
	}

	modules := make(page.Modules, 0, 366)
	day := calendar.DayTime{Time: time.Date(cfg.Year, time.January, 1, 0, 0, 0, 0, time.Local)}
	dayLayout := "Monday, 2"
	if cfg.ClearTopRightCorner {
		dayLayout = "Mon, 2"
	}

	for day.Year() == cfg.Year {
		right := header.Items{}
		_, weekNum := day.ISOWeek()
		left := header.Items{
			header.NewIntItem(cfg.Year),
			header.NewTextItem("Q" + strconv.Itoa(int(math.Ceil(float64(day.Month())/3.)))),
			header.NewMonthItem(day.Month()).Shorten(cfg.ClearTopRightCorner),
			header.NewTextItem("Week " + strconv.Itoa(weekNum)),
			header.NewTimeItem(day).SetLayout(dayLayout),
			header.NewTimeItem(day).SetLayout("Reflect").Ref().RefPrefix("reflect"),
		}

		if day.Month() != time.January || day.Day() != 1 {
			yesterday := day.AddDate(0, 0, -1)
			right = append(right, header.NewTimeItem(yesterday).SetLayout("Mon, 2").RefPrefix("reflect"))
		}

		if day.Month() != time.December || day.Day() != 31 {
			tomorrow := day.AddDate(0, 0, 1)
			right = append(right, header.NewTimeItem(tomorrow).SetLayout("Mon, 2").RefPrefix("reflect"))
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

func HeaderDailyReflect2(cfg config.Config, tpls []string) (page.Modules, error) {
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
				"TodayReflect": day,
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
