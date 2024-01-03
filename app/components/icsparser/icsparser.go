package icsparser

import (
	"fmt"
	"os"
	"time"

	ical "github.com/arran4/golang-ical"
)

type Event struct {
	Date          time.Time
	FormattedDate string
	Summary       string
}

func ParseICSFile(filePath string) ([]Event, error) {
	file, err := os.Open(filePath)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	calendar, err := ical.ParseCalendar(file)
	if err != nil {
		return nil, err
	}

	var events []Event
	for _, component := range calendar.Events() {
		dateStr := component.GetProperty(ical.ComponentPropertyDtStart).Value
		parsedDate, err := time.Parse("20060102T150405Z", dateStr)
		if err != nil {
			return nil, fmt.Errorf("could not convert Event.Date: %w", err)
		}
		event := Event{
			Date:    parsedDate,
			Summary: component.GetProperty(ical.ComponentPropertySummary).Value,
		}
		events = append(events, event)
	}

	return events, nil
}
