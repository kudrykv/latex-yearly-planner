package cal2

import (
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/header"
)

type Years []*Year
type Year struct {
	Number   int
	Quarters Quarters
	Weeks    Weeks
}

func NewYear(wd time.Weekday, year int) *Year {
	out := &Year{Number: year}
	out.Weeks = NewWeeksForYear(wd, out)

	for q := 1; q <= 4; q++ {
		out.Quarters = append(out.Quarters, NewQuarter(wd, out, q))
	}

	return out
}

func (y Year) Breadcrumb() string {
	return header.Items{
		header.NewIntItem(y.Number).Ref(),
		header.NewItemsGroup(
			header.NewTextItem("Q1"),
			header.NewTextItem("Q2"),
			header.NewTextItem("Q3"),
			header.NewTextItem("Q4"),
		),
	}.Table(true)
}
