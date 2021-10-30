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

	ref := d.Time.Format(time.RFC3339)
	day := strconv.Itoa(d.Time.Day())

	if larg, _ := large.(bool); larg {
		return `\hyperlink{` + ref + `}{\begin{tabular}{@{}p{5mm}@{}|}\hfil{}` + day + `\\ \hline\end{tabular}}`
	}

	return hyper.Link(ref, day)
}
