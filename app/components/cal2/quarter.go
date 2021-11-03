package cal2

import (
	"strconv"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/header"
	"github.com/kudrykv/latex-yearly-planner/app/components/hyper"
)

type Quarters []*Quarter

func (q Quarters) Numbers() []int {
	if len(q) == 0 {
		return nil
	}

	out := make([]int, 0, len(q))

	for _, quarter := range q {
		out = append(out, quarter.Number)
	}

	return out
}

type Quarter struct {
	Year   *Year
	Number int
	Months Months
}

func NewQuarter(wd time.Weekday, year *Year, qrtr int) *Quarter {
	out := &Quarter{Year: year, Number: qrtr}

	start := time.Month(qrtr*3 - 2)
	end := start + 2

	for month := start; month <= end; month++ {
		out.Months = append(out.Months, NewMonth(wd, year, out, month))
	}

	return out
}

func (q *Quarter) Breadcrumb() string {
	return header.Items{header.NewIntItem(q.Year.Number), header.NewItemsGroup(
		header.NewTextItem("Q1").Bold(q.Number == 1).Ref(q.Number == 1),
		header.NewTextItem("Q2").Bold(q.Number == 2).Ref(q.Number == 2),
		header.NewTextItem("Q3").Bold(q.Number == 3).Ref(q.Number == 3),
		header.NewTextItem("Q4").Bold(q.Number == 4).Ref(q.Number == 4),
	)}.Table(true)
}

func (q *Quarter) Name() string {
	return "Q" + strconv.Itoa(q.Number)
}

func (q *Quarter) HeadingMOS() string {
	return ` \begin{tabular}{@{}l}
  \resizebox{!}{\myLenHeaderResizeBox}{` + hyper.Target(q.Name(), q.Name()) + `}
\end{tabular}`
}
