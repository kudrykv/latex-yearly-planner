package icsparser

import (
    "testing"
	"github.com/stretchr/testify/assert"
)

func TestParseICSFile(t *testing.T) {
    filePath := "example_calendar.ics"

    events, err := ParseICSFile(filePath)
    assert.NoError(t, err)
    assert.NotNil(t, events)
    assert.Equal(t, 21, len(events), "Number of events does not match expected length")

    firstEvent := events[0]
    assert.Equal(t, "Daily Morning Briefing", firstEvent.Summary, "Summary does not match")

    assert.Equal(t, "05-01-2024", firstEvent.FormattedDate, "FormattedDate does not match")
    assert.Equal(t, "09:00", firstEvent.FormattedTime, "FormattedTime does not match")
}
