package compose

import (
	"math"
	"strconv"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/header"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func Daily(cfg config.Config) (string, []page.Page) {
	pages := make([]page.Page, 0, 366)

	day := time.Date(cfg.Year, time.January, 1, 0, 0, 0, 0, time.Local)

	for day.Year() == cfg.Year {
		right := header.Items{}
		_, weekNum := day.ISOWeek()
		left := header.Items{
			header.NewIntItem(cfg.Year),
			header.NewTextItem("Q" + strconv.Itoa(int(math.Ceil((float64(day.Month())/3.)+1)))),
			header.NewMonthItem(day.Month()),
			header.NewTextItem("Week " + strconv.Itoa(weekNum)),
			header.NewTimeItem(day).SetLayout("Monday, 2"),
		}

		if day.Month() != time.January || day.Day() != 1 {
			right = append(right, header.NewTextItem(day.AddDate(0, 0, -1).Format("Mon, 2")))
		}

		if day.Month() != time.December || day.Day() != 31 {
			right = append(right, header.NewTextItem(day.AddDate(0, 0, 1).Format("Mon, 2")))
		}

		pages = append(pages, page.Page{
			Header: header.Header{
				Left:  left,
				Right: right,
			},
			Body: day,
		})

		day = day.AddDate(0, 0, 1)
	}

	return cfg.Blocks.Daily.Tpl, pages
}
