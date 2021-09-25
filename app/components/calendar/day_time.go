package calendar

import (
	"strconv"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/hyper"
)

type DayTime struct {
	time.Time
}

func (d DayTime) AddDate(years, months, days int) DayTime {
	return DayTime{Time: d.Time.AddDate(years, months, days)}
}

func (d DayTime) Link() string {
	return hyper.Link(d.RefText(), strconv.Itoa(d.Day()))
}

func (d DayTime) SquareLink() string {
	ref := d.RefText()
	day := strconv.Itoa(d.Day())

	return `\hyperlink{` + ref + `}{\begin{tabular}{@{}p{5mm}@{}|}\hfil{}` + day + `\\ \hline\end{tabular}}`
}

func (d DayTime) SelectedCell() string {
	return `\cellcolor{black}{\textcolor{white}{` + strconv.Itoa(d.Day()) + `}}`
}

func (d DayTime) RefText() string {
	return d.Format(time.RFC3339)
}

func (d DayTime) FormatHour(ampm bool) string {
	if ampm {
		return d.Format("3 PM")
	}

	return d.Format("15")
}
