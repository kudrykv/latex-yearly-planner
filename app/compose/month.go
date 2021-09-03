package compose

import (
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/calendar"
	"github.com/kudrykv/latex-yearly-planner/app/components/header"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func Month(cfg config.Config) (string, []page.Page) {
	pages := make([]page.Page, 0, 12)

	for month := time.January; month <= time.December; month++ {
		pages = append(pages, page.Page{
			Header: header.Header{},
			Body:   calendar.NewYearMonth(cfg.Year, month).Calendar(cfg.WeekStart),
		})
	}

	return "month.tpl", pages
}
