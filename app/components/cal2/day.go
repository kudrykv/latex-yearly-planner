package cal2

import (
	"strconv"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/hyper"
)

type Days []*Day
type Day struct {
	Time time.Time
}

func (d Day) Day(large interface{}) string {
	if d.Time.IsZero() {
		return ""
	}

	day := strconv.Itoa(d.Time.Day())

	if larg, _ := large.(bool); larg {
		return `\hyperlink{` + d.ref() + `}{\begin{tabular}{@{}p{5mm}@{}|}\hfil{}` + day + `\\ \hline\end{tabular}}`
	}

	return hyper.Link(d.ref(), day)
}

func (d Day) ref() string {
	return d.Time.Format(time.RFC3339)
}

func (d Day) Next(days int) Day {
	return Day{Time: d.Time.AddDate(0, 0, days)}
}

func (d Day) WeekLink() string {
	return hyper.Link(d.ref(), strconv.Itoa(d.Time.Day())+", "+d.Time.Weekday().String())
}
