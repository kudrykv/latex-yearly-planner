package cal2

import (
	"math"
	"strconv"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/header"
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

func (d Day) Breadcrumb() string {
	_, wn := d.Time.ISOWeek()

	return header.Items{
		header.NewIntItem(d.Time.Year()),
		header.NewTextItem("Q" + strconv.Itoa(int(math.Ceil(float64(d.Time.Month())/3.)))),
		header.NewMonthItem(d.Time.Month()),
		header.NewTextItem("Week " + strconv.Itoa(wn)),
		header.NewTextItem(d.Time.Format("Monday, 2")).RefText(d.Time.Format(time.RFC3339)).Ref(true),
	}.Table(true)
}

func (d Day) Extra() header.Items {
	return header.Items{}
}

func (d Day) Hours(bottom, top int) Days {
	moment := time.Date(1, 1, 1, bottom, 0, 0, 0, time.Local)
	list := make(Days, 0, top-bottom+1)

	for i := bottom; i <= top; i++ {
		list = append(list, &Day{moment})
		moment = moment.Add(time.Hour)
	}

	return list
}

func (d Day) FormatHour(ampm interface{}) string {
	if doAmpm, _ := ampm.(bool); doAmpm {
		return d.Time.Format("3 PM")
	}

	return d.Time.Format("15")
}
