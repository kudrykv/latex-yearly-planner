package calendar

import "time"

type Months []Month

type Month struct {
	Raw time.Time
}
