package calendar

import "time"

type Weekday struct {
	Raw time.Weekday
}

func (r Weekday) RightDistanceTo(weekday Weekday) int {
	left := r.Raw
	right := weekday.Raw

	if left < right {
		left += 7
	}

	return int(left-right) % 7
}

var (
	Sunday    = Weekday{Raw: time.Sunday}
	Monday    = Weekday{Raw: time.Monday}
	Tuesday   = Weekday{Raw: time.Tuesday}
	Wednesday = Weekday{Raw: time.Wednesday}
	Thursday  = Weekday{Raw: time.Thursday}
	Friday    = Weekday{Raw: time.Friday}
	Saturday  = Weekday{Raw: time.Saturday}
)
