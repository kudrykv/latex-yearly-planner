package calendar

import "time"

type Months []Month

func NewMonths(weekday Weekday, fromYear int, fromMonth time.Month, toYear int, toMonth time.Month) Months {
	months := make(Months, 0)

	for year := fromYear; year <= toYear; year++ {
		fromMonth := fromMonth
		toMonth := toMonth

		if year != fromYear {
			fromMonth = time.January
		}

		if year != toYear {
			toMonth = time.December
		}

		for month := fromMonth; month <= toMonth; month++ {
			months = append(months, Month{Year: year, Month: month, Weekday: weekday})
		}
	}

	return months
}

type Month struct {
	Year    int
	Month   time.Month
	Weekday Weekday
}

func (r Month) Name() string {
	return r.Month.String()
}
