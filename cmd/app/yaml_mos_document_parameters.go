package app

import (
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/mosdocument"
	"github.com/kudrykv/latex-yearly-planner/internal/core/entities"
	"gopkg.in/yaml.v3"
	"regexp"
	"strconv"
	"time"
)

type YAMLMOS struct {
	Document   YAMLDocumentParameters `yaml:"document"`
	Parameters YAMLParameters         `yaml:"parameters"`
}

type YAMLDocumentParameters struct {
	Layout YAMLLayout

	DebugOptions YAMLDebugOptions
}

func (r YAMLMOS) ToDocumentParameters() mosdocument.DocumentParameters {
	return mosdocument.DocumentParameters{
		Layout:       r.Document.Layout.ToLayout(),
		DebugOptions: r.Document.DebugOptions.ToDebugOptions(),
	}
}

func (r YAMLMOS) ToParameters() mos.Parameters {
	panic("not implemented")
}

type YAMLDimensions struct {
	Width  entities.Length `yaml:"width"`
	Height entities.Length `yaml:"height"`
}

func (r YAMLDimensions) ToDimensions() mosdocument.Dimensions {
	return mosdocument.Dimensions{
		Width:  r.Width,
		Height: r.Height,
	}
}

type YAMLLayout struct {
	Dimensions  YAMLDimensions  `yaml:"dimensions"`
	Margin      YAMLMargin      `yaml:"margin"`
	MarginNotes YAMLMarginNotes `yaml:"margin_notes"`
}

func (r YAMLLayout) ToLayout() mosdocument.Layout {
	return mosdocument.Layout{
		Dimensions:  r.Dimensions.ToDimensions(),
		Margin:      r.Margin.ToMargin(),
		MarginNotes: r.MarginNotes.ToMarginNotes(),
	}
}

type YAMLMargin struct {
	Top    entities.Length `yaml:"top"`
	Right  entities.Length `yaml:"right"`
	Bottom entities.Length `yaml:"bottom"`
	Left   entities.Length `yaml:"left"`
}

func (r YAMLMargin) ToMargin() mosdocument.Margin {
	return mosdocument.Margin{
		Top:    r.Top,
		Right:  r.Right,
		Bottom: r.Bottom,
		Left:   r.Left,
	}
}

type YAMLMarginNotes struct {
	Width     entities.Length `yaml:"width"`
	Separator entities.Length `yaml:"separator"`
	Placement string          `yaml:"placement"`
}

func (r YAMLMarginNotes) ToMarginNotes() mosdocument.MarginNotes {
	return mosdocument.MarginNotes{
		Width:     r.Width,
		Separator: r.Separator,
		Placement: r.Placement,
	}
}

type YAMLDebugOptions struct {
	Enabled bool `yaml:"enabled"`

	HighlightLinks  bool `yaml:"highlight_links"`
	HighlightFrames bool `yaml:"highlight_frames"`
}

func (r YAMLDebugOptions) ToDebugOptions() mosdocument.DebugOptions {
	return mosdocument.DebugOptions{
		Enabled:         r.Enabled,
		HighlightLinks:  r.HighlightLinks,
		HighlightFrames: r.HighlightFrames,
	}
}

type YAMLParameters struct {
	StartDate       YAMLDate `yaml:"start_date"`
	EndDate         YAMLDate `yaml:"end_date"`
	WeekdayStart    string   `yaml:"weekday_start"`
	ShowWeekNumbers bool     `yaml:"show_week_numbers"`
	FormatAMPM      bool     `yaml:"format_ampm"`
}

var dateRegex = regexp.MustCompile(`(?i)(^\d{4}),?\s* (january|february|march|april|may|june|july|august|september|november|october|december)$`)

type YAMLDate time.Time

func (r *YAMLDate) UnmarshalYAML(value *yaml.Node) error {
	if value.Tag != "!!str" {
		return entities.ErrNotAString
	}

	if !dateRegex.MatchString(value.Value) {
		return fmt.Errorf("expected '<year>, <month_name>':%w", entities.ErrBadPattern)
	}

	matches := dateRegex.FindAllStringSubmatch(value.Value, -1)[0]
	stringYear, stringMonth := matches[1], matches[2]

	year, err := strconv.Atoi(stringYear)
	if err != nil {
		return fmt.Errorf("parse year: %w", err)
	}

	month, err := parseMonth(stringMonth)
	if err != nil {
		return fmt.Errorf("parse month: %w", err)
	}

	*r = YAMLDate(time.Date(year, month, 1, 0, 0, 0, 0, time.Local))

	return nil
}

func parseMonth(month string) (time.Month, error) {
	switch {
	case regexp.MustCompile("(?i)january").MatchString(month):
		return time.January, nil
	case regexp.MustCompile("(?i)february").MatchString(month):
		return time.February, nil
	case regexp.MustCompile("(?i)march").MatchString(month):
		return time.March, nil
	case regexp.MustCompile("(?i)april").MatchString(month):
		return time.April, nil
	case regexp.MustCompile("(?i)may").MatchString(month):
		return time.May, nil
	case regexp.MustCompile("(?i)june").MatchString(month):
		return time.June, nil
	case regexp.MustCompile("(?i)july").MatchString(month):
		return time.July, nil
	case regexp.MustCompile("(?i)august").MatchString(month):
		return time.August, nil
	case regexp.MustCompile("(?i)september").MatchString(month):
		return time.September, nil
	case regexp.MustCompile("(?i)october").MatchString(month):
		return time.October, nil
	case regexp.MustCompile("(?i)november").MatchString(month):
		return time.November, nil
	case regexp.MustCompile("(?i)december").MatchString(month):
		return time.December, nil
	default:
		return 0, fmt.Errorf("unknown month: %s", month)
	}
}
