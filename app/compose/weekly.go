package compose

import (
	"strconv"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/calendar"
	"github.com/kudrykv/latex-yearly-planner/app/components/header"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func Weekly(cfg config.Config) (string, []page.Page) {
	sow := pickUpStartWeekForTheYear(cfg.Year, cfg.WeekStart)
	pages := make([]page.Page, 0, 53)

	yearInWeeks := calendar.FillWeekly(sow).FillYear()
	for i, weekly := range yearInWeeks {
		right := header.Items{}
		if i > 0 {
			right = append(right, header.NewTextItem("Week "+strconv.Itoa(yearInWeeks[i-1].WeekNumber())))
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

		pag := page.Page{
			Header: header.Header{
				Right: right,
				Left: header.Items{
					header.NewIntItem(cfg.Year),
					header.NewItemsGroup(qrtrItems...).Delim(" / "),
					header.NewItemsGroup(monthItems...).Delim(" / "),
					header.NewTextItem("Week " + strconv.Itoa(weekly.WeekNumber())).Ref(true),
				},
			},
			Body: weekly,
		}

		pages = append(pages, pag)
	}

	return cfg.Blocks.Weekly.Tpl, pages
}

func pickUpStartWeekForTheYear(year int, weekStart time.Weekday) time.Time {
	soy := time.Date(year, time.January, 1, 0, 0, 0, 0, time.Local)
	sow := soy

	for sow.Weekday() != weekStart {
		sow = sow.AddDate(0, 0, 1)
	}

	if sow.Year() == year && sow.Day() > 1 {
		sow = sow.AddDate(0, 0, -7)
	}

	return sow
}
