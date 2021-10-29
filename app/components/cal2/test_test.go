package cal2

import (
	"fmt"
	"testing"
	"time"
)

func TestTest(t *testing.T) {
	year := NewYear(time.Monday, 2021)
	fmt.Println(year)
}
