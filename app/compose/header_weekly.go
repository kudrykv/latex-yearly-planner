package compose

import (
	"fmt"
	"strconv"

	"github.com/kudrykv/latex-yearly-planner/app/components/calendar"
	"github.com/kudrykv/latex-yearly-planner/app/components/header"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func HeaderWeekly(cfg config.Config, tpls []string) (page.Modules, error) {
	if len(tpls) != 1 {
		return nil, fmt.Errorf("exppected one tpl, got %d %v", len(tpls), tpls)
	}

	modules := make(page.Modules, 0, 53)
	sow := pickUpStartWeekForTheYear(cfg.Year, cfg.WeekStart)
	yearInWeeks := calendar.FillWeekly(sow).FillYear()

	for i, weekly := range yearInWeeks {
		right := header.Items{}
		if i > 0 {
			item := header.NewTextItem("Week " + strconv.Itoa(yearInWeeks[i-1].WeekNumber()))

			if i-1 == 0 {
				item = item.RefPrefix("fw")
			}

			right = append(right, item)
		}

		if i+1 < len(yearInWeeks) {
			right = append(right, header.NewTextItem("Week "+strconv.Itoa(yearInWeeks[i+1].WeekNumber())))
		}

		qrtrItems := make([]header.Item, 0, 2)
		for _, qrtr := range weekly.Quarters(cfg.Year) {
			qrtrItems = append(qrtrItems, header.NewTextItem("Q"+strconv.Itoa(qrtr)))
		}

		monthItems := make([]header.Item, 0, 2)
		for _, month := range weekly.Months(cfg.Year) {
			monthItems = append(monthItems, header.NewMonthItem(month))
		}

		curr := header.NewTextItem("Week " + strconv.Itoa(weekly.WeekNumber())).Ref(true)
		if i == 0 {
			curr = curr.RefPrefix("fw")
		}

		modules = append(modules, page.Module{
			Cfg: cfg,
			Tpl: tpls[0],
			Body: header.Header{
				Right: right,
				Left: header.Items{
					header.NewIntItem(cfg.Year),
					header.NewItemsGroup(qrtrItems...).Delim(" / "),
					header.NewItemsGroup(monthItems...).Delim(" / "),
					curr,
				},
			},
		})
	}

	return modules, nil
}

func HeaderWeekly2(cfg config.Config, tpls []string) (page.Modules, error) {
	if len(tpls) != 1 {
		return nil, fmt.Errorf("exppected one tpl, got %d %v", len(tpls), tpls)
	}

	modules := make(page.Modules, 0, 53)
	sow := pickUpStartWeekForTheYear(cfg.Year, cfg.WeekStart)
	yearInWeeks := calendar.FillWeekly(sow).FillYear()

	for i, week := range yearInWeeks {
		var day calendar.DayTime
		var weekPrefix string

		for _, moment := range week {
			if moment.Year() == cfg.Year {
				day = moment

				break
			}
		}

		if i == 0 {
			weekPrefix = "fw"
		}

		modules = append(modules, page.Module{
			Cfg: cfg,
			Tpl: tpls[0],
			Body: map[string]interface{}{
				"Week":         week,
				"WeekPrefix":   weekPrefix,
				"Date":         day,
				"CalendarCell": header.NewCellItem("Calendar").Refer(strconv.Itoa(cfg.Year)),
				"ToDoCell":     header.NewCellItem("To Do").Refer("Todos Index"),
				"NotesCell":    header.NewCellItem("Notes").Refer("Notes Index"),
				"Months":       MonthsToCellItems(cfg.WeekStart, calendar.NewYearInMonths(cfg.Year).Selected(day).Reverse()),
				"Quarters":     QuartersToCellItems(calendar.NewYearInQuarters(cfg.Year).Reverse()),
			},
		})
	}

	return modules, nil
}
