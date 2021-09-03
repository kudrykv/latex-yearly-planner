package compose

import (
	"strconv"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/calendar"
	"github.com/kudrykv/latex-yearly-planner/app/components/header"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func Year(cfg config.Config) (string, []page.Page) {
	var quarters [][]calendar.Calendar

	for quarter := time.January; quarter <= time.December; quarter += 3 {
		weeks := make([]calendar.Calendar, 0, 3)

		for month := quarter; month < quarter+3; month++ {
			weeks = append(weeks, calendar.NewYearMonth(cfg.Year, month).Calendar(cfg.WeekStart))
		}

		quarters = append(quarters, weeks)
	}

	return "year.tpl", []page.Page{{
		Body: quarters,
		Header: header.Header{
			Left: header.Items{
				header.NewTextItem(strconv.Itoa(cfg.Year)),
				header.NewItemsGroup(
					header.NewTextItem("Q1"),
					header.NewTextItem("Q2"),
					header.NewTextItem("Q3"),
					header.NewTextItem("Q4"),
				),
			},
			Right: header.Items{header.NewTextItem("Notes"), header.NewTextItem("Todos")},
		},
	}}
}
