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
    assert.Equal(t, 22, len(events), "Number of events does not match expected length")

    firstEvent := events[0]
    assert.Equal(t, "Daily Morning Briefing", firstEvent.Summary, "Summary does not match")

    assert.Equal(t, "05-01-2024", firstEvent.FormattedDate, "FormattedDate does not match")
    assert.Equal(t, "09:00", firstEvent.FormattedTime, "FormattedTime does not match")

    secondEvent := events[1]
    expectedFormattedTime := "14:00"  // this works on GMT timezone, test is brittle but needed to test it
    expectedFormattedDate := "06-01-2024"

    assert.Equal(t, "Afternoon Meeting", secondEvent.Summary, "Summary does not match")
    assert.Equal(t, expectedFormattedDate, secondEvent.FormattedDate, "FormattedDate does not match")
    assert.Equal(t, expectedFormattedTime, secondEvent.FormattedTime, "FormattedTime does not match")

    thirdEvent := events[2] // the third event is using timezone based location, so we skip it. we can not currently handle it

    expectedFormattedTimeForThirdEvent := "12:00"  // Local time (GMT) in GMT+7
    expectedFormattedDateForThirdEvent := "06-01-2024"

    assert.Equal(t, "Weekly Yoga and Wellness Workshop", thirdEvent.Summary, "Summary does not match")
    assert.Equal(t, expectedFormattedDateForThirdEvent, thirdEvent.FormattedDate, "FormattedDate does not match")
    assert.Equal(t, expectedFormattedTimeForThirdEvent, thirdEvent.FormattedTime, "FormattedTime does not match")
}
