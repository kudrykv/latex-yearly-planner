package cal

import (
    "math"
    "strconv"
    "strings"
    "time"

    "github.com/kudrykv/latex-yearly-planner/app/components/header"
    "github.com/kudrykv/latex-yearly-planner/app/components/hyper"
    "github.com/kudrykv/latex-yearly-planner/app/tex"
    "github.com/kudrykv/latex-yearly-planner/app/texx"
)

type Days []*Day
type Day struct {
    Time time.Time
}

func (d Day) Day(today, large interface{}) string {
    if d.Time.IsZero() {
        return ""
    }

    day := strconv.Itoa(d.Time.Day())

    if larg, _ := large.(bool); larg {
        return `\hyperlink{` + d.ref() + `}{\begin{tabular}{@{}p{5mm}@{}}\hfil{}` + day + `\\ \end{tabular}}`
    }

    if td, ok := today.(Day); ok {
        if d.Time.Equal(td.Time) {
            return texx.EmphCell(day)
        }
    }

    return hyper.Link(d.ref(), day)
}

func (d Day) ref(prefix ...string) string {
    p := ""

    if len(prefix) > 0 {
        p = prefix[0]
    }

    return p + d.Time.Format(time.RFC3339)
}

func (d Day) Add(days int) Day {
    return Day{Time: d.Time.AddDate(0, 0, days)}
}

func (d Day) WeekLink() string {
    return hyper.Link(d.ref(), strconv.Itoa(d.Time.Day())+", "+d.Time.Weekday().String())
}

func (d Day) Breadcrumb(prefix string, leaf string, shorten bool) string {
    wpref := ""
    _, wn := d.Time.ISOWeek()
    if wn > 50 && d.Time.Month() == time.January {
        wpref = "fw"
    }

    dayLayout := "Monday, 2"
    if shorten {
        dayLayout = "Mon, 2"
    }

    dayItem := header.NewTextItem(d.Time.Format(dayLayout)).RefText(d.Time.Format(time.RFC3339))
    items := header.Items{
        header.NewIntItem(d.Time.Year()),
        header.NewTextItem("Q" + strconv.Itoa(int(math.Ceil(float64(d.Time.Month())/3.)))),
        header.NewMonthItem(d.Time.Month()).Shorten(shorten),
        header.NewTextItem("Week " + strconv.Itoa(wn)).RefPrefix(wpref),
    }

    if len(leaf) > 0 {
        items = append(items, dayItem, header.NewTextItem(leaf).RefText(prefix+d.ref()).Ref(true))
    } else {
        items = append(items, dayItem.Ref(true))
    }

    return items.Table(true)
}

func (d Day) LinkLeaf(prefix, leaf string) string {
    return hyper.Link(prefix+d.ref(), leaf)
}

func (d Day) PrevNext(prefix string) header.Items {
    items := header.Items{}

    if d.PrevExists() {
        prev := d.Prev()
        items = append(items, header.NewTextItem(prev.Time.Format("Mon, 2")).RefText(prefix+prev.ref()))
    }

    if d.NextExists() {
        next := d.Next()
        items = append(items, header.NewTextItem(next.Time.Format("Mon, 2")).RefText(prefix+next.ref()))
    }

    return items
}

func (d Day) Next() Day {
    return d.Add(1)
}

func (d Day) Prev() Day {
    return d.Add(-1)
}

func (d Day) NextExists() bool {
    return d.Time.Month() < time.December || d.Time.Day() < 31
}

func (d Day) PrevExists() bool {
    return d.Time.Month() > time.January || d.Time.Day() > 1
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

func (d Day) Quarter() int {
    return int(math.Ceil(float64(d.Time.Month()) / 3.))
}

func (d Day) Month() time.Month {
    return d.Time.Month()
}

func (d Day) HeadingMOS(prefix, leaf string) string {
    day := strconv.Itoa(d.Time.Day())
    if len(leaf) > 0 {
        day = hyper.Link(d.ref(), day)
    }

    anglesize := `\dimexpr\myLenHeaderResizeBox-0.86pt`

    var ll, rl string
    var r1, r2 []string

    if d.PrevExists() {
        ll = "l"
        leftNavBox := tex.ResizeBoxW(anglesize, `$\langle$`)
        r1 = append(r1, tex.Multirow(2, tex.Hyperlink(d.Prev().ref(prefix), leftNavBox)))
        r2 = append(r2, "")
    }

    r1 = append(r1, tex.Multirow(2, tex.ResizeBoxW(`\myLenHeaderResizeBox`, day)))
    r2 = append(r2, "")
    r1 = append(r1, tex.Bold(d.Time.Weekday().String()))
    r2 = append(r2, d.Time.Month().String())

    if d.NextExists() {
        rl = "l"
        rightNavBox := tex.ResizeBoxW(anglesize, `$\rangle$`)
        r1 = append(r1, tex.Multirow(2, tex.Hyperlink(d.Next().ref(prefix), rightNavBox)))
        r2 = append(r2, "")
    }

    contents := strings.Join(r1, ` & `) + `\\` + "\n" + strings.Join(r2, ` & `)
    return tex.Hypertarget(prefix+d.ref(), "") + tex.Tabular("@{}"+ll+"l|l"+rl, contents)
}
