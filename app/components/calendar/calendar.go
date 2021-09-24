package calendar

import (
	"strconv"
	"strings"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/hyper"
)

type Calendar struct {
	wd    time.Weekday
	weeks Weeklies
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

func (c Calendar) Matrix() Weeklies {
	return c.weeks
}

func (c Calendar) MatrixTexed(withWeeks, weeksLong, squareDays bool, today interface{}) string {
	mx := c.Matrix()

	out := make([]string, 0, len(mx))

	weeks := make([]int, 0, len(mx))
	weeks = append(weeks, mx[0].WeekNumber())

	for i := 1; i < len(mx); i++ {
		wn := mx[i].WeekNumber()

		if wn == weeks[i-1] {
			wn++
		}

		weeks = append(weeks, wn)
	}

	for i, weekly := range mx {
		row := make([]string, 0, len(weekly))

		if withWeeks {
			prefix := ""
			text := ""

			if c.MonthName() == time.January && weekly.WeekNumber() > 50 {
				prefix = "fw"
			}

			if weeksLong {
				text = "Week "
			}

			text += strconv.Itoa(weeks[i])

			if weeksLong {
				text = `\rotatebox[origin=tr]{90}{\makebox[\myLenMonthlyCellHeight][c]{` + text + `}}`
			}

			row = append(row, hyper.Link(prefix+"Week "+strconv.Itoa(weeks[i]), text))
		}

		for _, dayTime := range weekly {
			if dayTime.IsZero() {
				row = append(row, "")

				continue
			}

			if squareDays {
				row = append(row, `\hyperlink{`+dayTime.RefText()+`}{\begin{tabular}{@{}p{5mm}@{}|}\hfil{}`+strconv.Itoa(dayTime.Day())+`\\ \hline\end{tabular}}`)

				continue
			}

			if td, ok := today.(DayTime); ok && dayTime.Equal(td.Time) {
				row = append(row, `\cellcolor{black}{\textcolor{white}{`+strconv.Itoa(td.Day())+`}}`)

				continue
			}

			row = append(row, dayTime.Link())
		}

		out = append(out, strings.Join(row, " & "))
	}

	if squareDays {
		return strings.Join(out, "\\\\ \\hline\n") + "\\\\ \\hline"
	}

	return strings.Join(out, " \\\\\n")
}
