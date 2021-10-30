package cal2

import (
	"strconv"
	"time"
)

type Days []*Day
type Day struct {
	Time time.Time
}

func (d Day) Day() string {
	if d.Time.IsZero() {
		return ""
	}

	return strconv.Itoa(d.Time.Day())
}
