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

	assert.Equal(t, 1142, len(events), "Number of events does not match expected length")
}
