package mosdocument

import "github.com/kudrykv/latex-yearly-planner/internal/core/entities"

type DocumentParameters struct {
	Layout Layout

	DebugOptions DebugOptions
}

type Layout struct {
	Dimensions  Dimensions
	Margin      Margin
	MarginNotes MarginNotes
}

type Dimensions struct {
	Width  entities.Millimeters
	Height entities.Millimeters
}

type Margin struct {
	Top    entities.Millimeters
	Right  entities.Millimeters
	Bottom entities.Millimeters
	Left   entities.Millimeters
}

type MarginNotes struct {
	Width     entities.Millimeters
	Separator entities.Millimeters
	Placement string
}

type DebugOptions struct {
	Enabled bool

	HighlightLinks  bool
	HighlightFrames bool
}
