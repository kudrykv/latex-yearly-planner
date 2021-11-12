package cal

import (
	"math"
	"strconv"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/header"
	"github.com/kudrykv/latex-yearly-planner/app/components/hyper"
	"github.com/kudrykv/latex-yearly-planner/app/tex"
)

type Weeks []*Week
type Week struct {
	Days [7]Day

	Weekday  time.Weekday
	Year     *Year
	Months   Months
	Quarters Quarters
}

func NewWeeksForMonth(wd time.Weekday, year *Year, qrtr *Quarter, month *Month) Weeks {
	ptr := time.Date(year.Number, month.Month, 1, 0, 0, 0, 0, time.Local)
	weekday := ptr.Weekday()
	shift := (7 + weekday - wd) % 7

	week := &Week{Weekday: wd, Year: year, Months: Months{month}, Quarters: Quarters{qrtr}}

	for i := shift; i < 7; i++ {
		week.Days[i] = Day{Time: ptr}
		ptr = ptr.AddDate(0, 0, 1)
	}

	weeks := Weeks{}
	weeks = append(weeks, week)

	for ptr.Month() == month.Month {
		week = &Week{Weekday: weekday, Year: year, Months: Months{month}, Quarters: Quarters{qrtr}}

		for i := 0; i < 7; i++ {
			if ptr.Month() != month.Month {
				break
			}

			week.Days[i] = Day{ptr}
			ptr = ptr.AddDate(0, 0, 1)
		}

		weeks = append(weeks, week)
	}

	return weeks
}

func NewWeeksForYear(wd time.Weekday, year *Year) Weeks {
	ptr := selectStartWeek(year.Number, wd)

	qrtr1 := NewQuarter(wd, year, 1)
	mon1 := NewMonth(wd, year, qrtr1, time.January)
	week := &Week{Weekday: wd, Year: year, Quarters: Quarters{qrtr1}, Months: Months{mon1}}
	weeks := make(Weeks, 0, 53)

	for i := 0; i < 7; i++ {
		week.Days[i] = ptr
		ptr = ptr.Next(1)
	}

	weeks = append(weeks, week)

	for ptr.Time.Year() == year.Number {
		weeks = append(weeks, fillWeekly(wd, year, ptr))
		ptr = ptr.Next(7)
	}

	weeks[len(weeks)-1].Quarters = weeks[len(weeks)-1].Quarters[:1]
	weeks[len(weeks)-1].Months = weeks[len(weeks)-1].Months[:1]

	return weeks
}

func fillWeekly(wd time.Weekday, year *Year, ptr Day) *Week {
	qrtr := NewQuarter(wd, year, int(math.Ceil(float64(ptr.Time.Month())/3.)))
	month := NewMonth(wd, year, qrtr, ptr.Time.Month())

	week := &Week{Weekday: wd, Year: year, Quarters: Quarters{qrtr}, Months: Months{month}}

	for i := 0; i < 7; i++ {
		week.Days[i] = ptr
		ptr = ptr.Next(1)
	}

	if week.quarterOverlap() {
		qrtr = NewQuarter(wd, year, week.rightQuarter())
		week.Quarters = append(week.Quarters, qrtr)
	}

	if week.monthOverlap() {
		month = NewMonth(wd, year, qrtr, week.rightMonth())
		week.Months = append(week.Months, month)
	}

	return week
}

func selectStartWeek(year int, weekStart time.Weekday) Day {
	soy := time.Date(year, time.January, 1, 0, 0, 0, 0, time.Local)
	sow := soy

	for sow.Weekday() != weekStart {
		sow = sow.AddDate(0, 0, 1)
	}

	if sow.Year() == year && sow.Day() > 1 {
		sow = sow.AddDate(0, 0, -7)
	}

	return Day{Time: sow}
}

func (w *Week) WeekNumber(large interface{}) string {
	wn := w.weekNumber()
	larg, _ := large.(bool)

	itoa := strconv.Itoa(wn)
	ref := w.ref()
	if !larg {
		return hyper.Link(ref, itoa)
	}

	text := `\rotatebox[origin=tr]{90}{\makebox[\myLenMonthlyCellHeight][c]{Week ` + itoa + `}}`

	return hyper.Link(ref, text)
}

func (w *Week) weekNumber() int {
	_, wn := w.Days[0].Time.ISOWeek()

	for _, t := range w.Days {
		if _, cwn := t.Time.ISOWeek(); !t.Time.IsZero() && cwn != wn {
			return cwn
		}
	}

	return wn
}

func (w *Week) Breadcrumb() string {
	return header.Items{
		header.NewIntItem(w.Year.Number),
		w.QuartersBreadcrumb(),
		w.MonthsBreadcrumb(),
		header.NewTextItem("Week " + strconv.Itoa(w.weekNumber())).RefText(w.ref()).Ref(true),
	}.Table(true)
}

func (w *Week) monthOverlap() bool {
	return w.Days[0].Time.Month() != w.Days[6].Time.Month()
}

func (w *Week) quarterOverlap() bool {
	return w.leftQuarter() != w.rightQuarter()
}

func (w *Week) leftQuarter() int {
	return int(math.Ceil(float64(w.Days[0].Time.Month()) / 3.))
}

func (w *Week) rightQuarter() int {
	return int(math.Ceil(float64(w.Days[6].Time.Month()) / 3.))
}

func (w *Week) rightMonth() time.Month {
	for i := 6; i >= 0; i-- {
		if w.Days[i].Time.IsZero() {
			continue
		}

		return w.Days[i].Time.Month()
	}

	return -1
}

func (w *Week) PrevNext() header.Items {
	items := header.Items{}

	if w.PrevExists() {
		wn := w.Prev().weekNumber()
		items = append(items, header.NewTextItem("Week "+strconv.Itoa(wn)))
	}

	if w.NextExists() {
		wn := w.Next().weekNumber()
		items = append(items, header.NewTextItem("Week "+strconv.Itoa(wn)))
	}

	return items
}

func (w *Week) NextExists() bool {
	stillThisYear := w.Days[6].Time.Year() == w.Year.Number
	isntTheLastDayOfTheYear := w.Days[0].Time.Month() != time.December || w.Days[0].Time.Day() != 31
	return stillThisYear && isntTheLastDayOfTheYear
}

func (w *Week) PrevExists() bool {
	stilThisYear := w.Days[0].Time.Year() == w.Year.Number
	isntTheFirstDayOfTheYear := w.Days[0].Time.Month() != time.January || w.Days[0].Time.Day() != 1
	return stilThisYear && isntTheFirstDayOfTheYear
}

func (w *Week) Next() *Week {
	return fillWeekly(w.Weekday, w.Year, w.Days[0].Next(7))
}

func (w *Week) Prev() *Week {
	return fillWeekly(w.Weekday, w.Year, w.Days[0].Next(-7))
}

func (w *Week) QuartersBreadcrumb() header.ItemsGroup {
	group := header.ItemsGroup{}.Delim(" / ")

	for _, quarter := range w.Quarters {
		group.Items = append(group.Items, header.NewTextItem("Q"+strconv.Itoa(quarter.Number)))
	}

	return group
}

func (w *Week) MonthsBreadcrumb() header.ItemsGroup {
	group := header.ItemsGroup{}.Delim(" / ")

	for _, month := range w.Months {
		group.Items = append(group.Items, header.NewMonthItem(month.Month))
	}

	return group
}

func (w *Week) ref() string {
	prefix := ""
	wn := w.weekNumber()
	rm := w.rightMonth()
	ry := w.rightYear()

	if wn > 50 && rm == time.January && ry == w.Year.Number {
		prefix = "fw"
	}

	return prefix + "Week " + strconv.Itoa(wn)
}

func (w *Week) leftMonth() time.Month {
	for _, day := range w.Days {
		if day.Time.IsZero() {
			continue
		}

		return day.Time.Month()
	}

	return -1
}

func (w *Week) rightYear() int {
	for i := 6; i >= 0; i-- {
		if w.Days[i].Time.IsZero() {
			continue
		}

		return w.Days[i].Time.Year()
	}

	return -1
}

func (w *Week) HeadingMOS() string {
	return tex.Tabular("@{}l", tex.ResizeBoxW(`\myLenHeaderResizeBox`, w.Target()+`\myDummyQ`))
}

func (w *Week) Name() string {
	return "Week " + strconv.Itoa(w.weekNumber())
}

func (w *Week) Target() string {
	return tex.Hypertarget(w.ref(), w.Name())
}
