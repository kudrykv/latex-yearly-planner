package calendar_test

import (
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/internal/core/calendar"
	"github.com/stretchr/testify/require"
	"testing"
	"time"
)

func TestNewWeeksOfMonth(t *testing.T) {
	t.Parallel()

	table := []struct {
		month               calendar.Month
		firstDayInFirstWeek int
		lastDayInLastWeek   int
	}{
		{
			month:               calendar.Month{Year: 2023, Month: time.June, Weekday: calendar.Monday},
			firstDayInFirstWeek: 3,
			lastDayInLastWeek:   4,
		},

		{
			month:               calendar.Month{Year: 2023, Month: time.June, Weekday: calendar.Sunday},
			firstDayInFirstWeek: 4,
			lastDayInLastWeek:   5,
		},

		{
			month:               calendar.Month{Year: 2023, Month: time.June, Weekday: calendar.Friday},
			firstDayInFirstWeek: 6,
			lastDayInLastWeek:   0,
		},
	}

	for _, tt := range table {
		tt := tt

		t.Run(fmt.Sprintf("%d %s %s", tt.month.Year, tt.month.Month, tt.month.Weekday), func(t *testing.T) {
			t.Parallel()

			weeks := calendar.NewWeeksOfMonth(tt.month)

			require.False(t, weeks[0].Days[tt.firstDayInFirstWeek].IsZero())
			require.Equal(t, 1, weeks[0].Days[tt.firstDayInFirstWeek].Day())

			require.False(t, weeks[len(weeks)-1].Days[tt.lastDayInLastWeek].IsZero())
			require.Equal(t, 30, weeks[len(weeks)-1].Days[tt.lastDayInLastWeek].Day())
		})
	}
}
