package app

import (
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/mosdocument"
	"github.com/kudrykv/latex-yearly-planner/internal/core/entities"
)

type YAMLMOS struct {
	Document YAMLDocumentParameters `yaml:"document"`
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
