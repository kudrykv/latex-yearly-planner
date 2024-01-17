package icsparser

import (
	"fmt"
	"os"
	"strings"
	"time"

	ical "github.com/arran4/golang-ical"
)

type Event struct {
	Date          time.Time
	FormattedDate string
	FormattedTime string
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
		
		// Skip events that don't end with 'Z' (not in UTC format)
        if !strings.HasSuffix(dateStr, "Z") {
            continue
        }

		parsedDate, err := time.Parse("20060102T150405Z", dateStr)
		if err != nil {
			return nil, fmt.Errorf("could not convert Event.Date: %w", err)
		}
		localLocation := time.Now().Location() // to present events based on current location
		localTime := parsedDate.In(localLocation)
		formattedTime := localTime.Format("15:04")
		formattedDate := localTime.Format("02-01-2006")
		event := Event{
			Date:    parsedDate,
			FormattedDate: formattedDate,
			FormattedTime: formattedTime,
			Summary: component.GetProperty(ical.ComponentPropertySummary).Value,
		}
		events = append(events, event)
	}

	return events, nil
}
