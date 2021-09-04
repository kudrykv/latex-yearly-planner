package calendar

import (
	"math"
	"strconv"
	"strings"
	"time"
)

type Weeks []Week
type Week [8]int

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
		if _, cwn := t.ISOWeek(); cwn > wn {
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

func (w Week) Start(wd time.Weekday, ptr time.Time) Week {
	_, weekNum := ptr.ISOWeek()
	ints := [8]int{weekNum}

	weekday := ptr.Weekday()
	shift := (7+weekday-wd)%7 + 1
	day := 1

	for i := shift; i < 8; i++ {
		ints[i] = day
		day++
	}

	return ints
}

func (w Week) Fill(year int, month time.Month) Weeks {
	weeks := Weeks{w}
	end := time.Date(year, month, 1, 0, 0, 0, 0, time.Local).AddDate(0, 1, 0).AddDate(0, 0, -1)

	for day := w[7] + 1; day <= end.Day(); day += 7 {
		_, isoWeek := time.Date(year, month, day, 0, 0, 0, 0, time.Local).ISOWeek()
		week := Week{isoWeek}

		for i := 0; i < 7; i++ {
			d := day + i
			if d > end.Day() {
				break
			}

			week[i+1] = d
		}

		weeks = append(weeks, week)
	}

	return weeks
}

func FillWeekly(ptr time.Time) Weekly {
	w := Weekly{}

	for i := 0; i < 7; i++ {
		w[i] = ptr
		ptr = ptr.AddDate(0, 0, 1)
	}

	return w
}

func (w Week) FillWeek(ptr time.Time) Week {
	_, w[0] = ptr.ISOWeek()

	for i := 1; i <= 7; i++ {
		w[i] = ptr.Day()

		if _, wn := ptr.ISOWeek(); wn > w[0] {
			w[0] = wn
		}

		ptr = ptr.AddDate(0, 0, 1)
	}

	return w
}

func (w Weeks) FigureOut(year int, month time.Month, wd time.Weekday) Weeks {
	ptr := time.Date(year, month, 1, 0, 0, 0, 0, time.Local)

	return Week{}.Start(wd, ptr).Fill(year, month)
}

type YearMonth struct {
	year  int
	month time.Month
}

func NewYearMonth(year int, month time.Month) YearMonth {
	return YearMonth{
		year:  year,
		month: month,
	}
}

func (m YearMonth) Calendar(wd time.Weekday) Calendar {
	return Calendar{
		month: m.month,
		wd:    wd,
		weeks: Weeks{}.FigureOut(m.year, m.month, wd),
	}
}

type Calendar struct {
	wd    time.Weekday
	weeks Weeks
	month time.Month
}

func (c Calendar) WeekLayout(weekNum bool) string {
	line := strings.Repeat("c", 7)
	if !weekNum {
		return line
	}

	return "c|" + line
}

func (c Calendar) WeekHeader(weekNum bool) string {
	names := append(make([]string, 0, 8), "W")

	for i := time.Sunday; i < 7; i++ {
		names = append(names, ((c.wd + i) % 7).String()[:1])
	}

	if !weekNum {
		names = names[1:]
	}

	return strings.Join(names, " & ")
}

func (c Calendar) WeekHeaderFull(weekNum bool) string {
	names := make([]string, 0, 7)

	for i := time.Sunday; i < 7; i++ {
		names = append(names, "\\hfil{}"+((c.wd+i)%7).String())
	}

	out := strings.Join(names, " & ")
	if weekNum {
		out = "& " + out
	}

	return out
}

func (c Calendar) WeekHeaderLen(weekNum bool) int {
	if weekNum {
		return 8
	}

	return 7
}

func (c Calendar) MonthName() time.Month {
	return c.month
}

func (c Calendar) DaysMatrix(weekNum bool) string {
	lines := make([]string, 0, 4)

	for _, week := range c.weeks {
		line := make([]string, 0, 8)

		if weekNum {
			line = append(line, strconv.Itoa(week[0]))
		}

		for _, day := range week[1:] {
			if day == 0 {
				line = append(line, "")

				continue
			}

			line = append(line, strconv.Itoa(day))
		}

		lines = append(lines, strings.Join(line, " & "))
	}

	return strings.Join(lines, " \\\\ \n")
}

func (c Calendar) Matrix(withWeeks, short bool) [][]string {
	rows := make([][]string, 0, len(c.weeks))

	for _, week := range c.weeks {
		row := make([]string, 0, len(week))

		if withWeeks {
			weeknumStr := strconv.Itoa(week[0])
			if !short {
				weeknumStr = "Week " + weeknumStr
			}

			row = append(row, weeknumStr)
		}

		for _, item := range week[1:] {
			if item == 0 {
				row = append(row, "")

				continue
			}

			row = append(row, strconv.Itoa(item))
		}

		rows = append(rows, row)
	}

	return rows
}
