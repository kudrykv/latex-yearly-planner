package cal2

import (
	"strconv"
	"strings"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/header"
	"github.com/kudrykv/latex-yearly-planner/app/components/hyper"
)

type Months []*Month
type Month struct {
	Year    *Year
	Quarter *Quarter
	Month   time.Month
	Weekday time.Weekday
	Weeks   Weeks
}

func NewMonth(wd time.Weekday, year *Year, qrtr *Quarter, month time.Month) *Month {
	m := &Month{
		Year:    year,
		Quarter: qrtr,
		Month:   month,
		Weekday: wd,
	}

	m.Weeks = NewWeeksForMonth(wd, year, qrtr, m)

	return m
}

func (m *Month) MaybeName(large interface{}) string {
	larg, _ := large.(bool)

	if larg { // likely on a monthly page; no need to print it again
		return ""
	}

	return `\multicolumn{8}{c}{` + hyper.Link(m.Month.String(), m.Month.String()) + `} \\ \hline`
}

func (m *Month) WeekHeader(large interface{}) string {
	full, _ := large.(bool)

	names := make([]string, 0, 8)

	if full {
		names = append(names, "")
	} else {
		names = append(names, "W")
	}

	for i := time.Sunday; i < 7; i++ {
		name := ((m.Weekday + i) % 7).String()
		if full {
			name = `\hfil{}` + name
		} else {
			name = name[:1]
		}

		names = append(names, name)
	}

	return strings.Join(names, " & ")
}

func (m *Month) DefineTable(typ interface{}, large interface{}) string {
	full, _ := large.(bool)

	typStr, ok := typ.(string)
	if !ok || typStr == "tabularx" {
		weekAlign := "Y|"
		days := "Y"
		if full {
			weekAlign = `|l!{\vrule width \myLenLineThicknessThick}`
			days = "@{}X@{}|"
		}

		return `\begin{tabularx}{\linewidth}{` + weekAlign + `*{7}{` + days + `}}`
	}

	return `\begin{tabular}[t]{c|*{7}{c}}`
}

func (m *Month) EndTable(typ interface{}) string {
	typStr, ok := typ.(string)
	if !ok || typStr == "tabularx" {
		return `\end{tabularx}`
	}

	return `\end{tabular}`
}

func (m *Month) Breadcrumb() string {
	return header.Items{
		header.NewIntItem(m.Year.Number),
		header.NewTextItem("Q" + strconv.Itoa(m.Quarter.Number)),
		header.NewMonthItem(m.Month).Ref(),
	}.Table(true)
}

func (m *Month) PrevNext() header.Items {
	items := header.Items{}

	if m.Month > time.January {
		items = append(items, header.NewMonthItem(m.Month-1))
	}

	if m.Month < time.December {
		items = append(items, header.NewMonthItem(m.Month+1))
	}

	return items
}