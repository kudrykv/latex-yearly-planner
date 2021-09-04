package compose

import (
	"strconv"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/calendar"
	"github.com/kudrykv/latex-yearly-planner/app/components/header"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

type QuarterBody struct {
	Quarter []calendar.Calendar
}

func Quarter(cfg config.Config) (string, []page.Page) {
	pages := make([]page.Page, 0, 4)
	q := 1
	hRight := header.Items{header.NewTextItem("Notes"), header.NewTextItem("Todos")}

	for quarter := time.January; quarter <= time.December; quarter += 3 {
		body := QuarterBody{Quarter: make([]calendar.Calendar, 0, 3)}
		hQrtrs := header.NewItemsGroup(
			header.NewTextItem("Q1").Bold(q == 1),
			header.NewTextItem("Q2").Bold(q == 2),
			header.NewTextItem("Q3").Bold(q == 3),
			header.NewTextItem("Q4").Bold(q == 4),
		)

		for month := quarter; month < quarter+3; month++ {
			cal := calendar.NewYearMonth(cfg.Year, month).Calendar(cfg.WeekStart)
			body.Quarter = append(body.Quarter, cal)
		}

		pages = append(pages, page.Page{
			Header: header.Header{
				Left: header.Items{
					header.TextItem{Name: strconv.Itoa(cfg.Year)},
					hQrtrs,
				},
				Right: hRight,
			},
			Body: body,
		})
		q++
	}

	return cfg.Blocks.Quarterly.Tpl, pages
}
