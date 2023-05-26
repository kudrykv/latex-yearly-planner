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

func (r Months) Weeks() Weeks {
	return nil

	//if len(r) == 0 {
	//	return nil
	//}
	//
	//cutoff := r[len(r)-1].LastDay()
	//
	//NewFirstWeek(r[0])
}

type Month struct {
	Year    int
	Month   time.Month
	Weekday Weekday
}

func (r Month) Name() string {
	return r.Month.String()
}

func (r Month) Weeks() Weeks {
	return NewWeeksOfMonth(r)
}

func (r Month) FirstDay() Day {
	return NewDay(r)
}

func (r Month) LastDay() Day {
	return NewDay(r).LastInMonth()
}
