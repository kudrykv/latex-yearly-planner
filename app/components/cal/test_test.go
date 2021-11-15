package cal_test

import (
	"fmt"
	"testing"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/cal"
)

func TestTest(t *testing.T) {
	year := cal.NewYear(time.Monday, 2021)
	weeks := cal.NewWeeksForYear(time.Monday, year)
	fmt.Println(weeks)
}
