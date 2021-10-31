package cal2_test

import (
	"fmt"
	"testing"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/cal2"
)

func TestTest(t *testing.T) {
	year := cal2.NewYear(time.Monday, 2021)
	weeks := cal2.NewWeeksForYear(time.Monday, year)
	fmt.Println(weeks)
}
