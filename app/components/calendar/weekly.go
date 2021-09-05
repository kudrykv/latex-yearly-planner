package calendar

import (
	"math"
	"strconv"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/hyper"
)

type Weeklies []Weekly
type Weekly [7]time.Time

func (w Weekly) FillYear() Weeklies {
	year := w[6].Year()
	ptr := w[6].AddDate(0, 0, 1)
	ww := append(make(Weeklies, 0, 53), w)

	for ptr.Year() == year {
		ww = append(ww, FillWeekly(ptr))
		ptr = ptr.AddDate(0, 0, 7)
	}

	return ww
}

func (w Weekly) WeekNumber() int {
	_, wn := w[0].ISOWeek()

	for _, t := range w {
		if _, cwn := t.ISOWeek(); !t.IsZero() && cwn != wn {
			return cwn
		}
	}

	return wn
}

func (w Weekly) Quarters(year int) []int {
	bottom := int(math.Ceil(float64(w[0].Month()) / 3.))
	top := int(math.Ceil(float64(w[6].Month()) / 3.))

	if w[0].Year() != year {
		return []int{top}
	}

	if w[6].Year() != year {
		return []int{bottom}
	}

	if top == bottom {
		return []int{top}
	}

	return []int{bottom, top}
}

func (w Weekly) Months(year int) []time.Month {
	bottom := w[0].Month()
	top := w[6].Month()

	if w[0].Year() != year {
		return []time.Month{top}
	}

	if w[6].Year() != year {
		return []time.Month{bottom}
	}

	if top == bottom {
		return []time.Month{top}
	}

	return []time.Month{bottom, top}
}

func (w Weekly) LinkWeek(prefix string, long bool) string {
	wn := strconv.Itoa(w.WeekNumber())
	if long {
		wn = "Week " + wn
	}

	return hyper.Link(prefix+"Week "+strconv.Itoa(w.WeekNumber()), wn)
}

func (w Weekly) RefText(prefix string) string {
	return prefix + "Week " + strconv.Itoa(w.WeekNumber())
}

func (w Weekly) Text(long bool) string {
	wn := strconv.Itoa(w.WeekNumber())
	if long {
		return "Week " + wn
	}

	return wn
}

func FillWeekly(ptr time.Time) Weekly {
	w := Weekly{}

	for i := 0; i < 7; i++ {
		w[i] = ptr
		ptr = ptr.AddDate(0, 0, 1)
	}

	return w
}

func MonthWeeklies(wd time.Weekday, year int, month time.Month) Weeklies {
	weeklies := make(Weeklies, 0, 5)
	weekly := Weekly{}

	ptr := time.Date(year, month, 1, 0, 0, 0, 0, time.Local)
	weekday := ptr.Weekday()
	shift := (7 + weekday - wd) % 7

	for i := shift; i < 7; i++ {
		weekly[i] = ptr
		ptr = ptr.AddDate(0, 0, 1)
	}

	weeklies = append(weeklies, weekly)

	for ptr.Month() == month {
		weekly = Weekly{}

		for i := 0; i < 7; i++ {
			if ptr.Month() != month {
				break
			}

			weekly[i] = ptr
			ptr = ptr.AddDate(0, 0, 1)
		}

		weeklies = append(weeklies, weekly)
	}

	return weeklies
}
