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
	Width  entities.Length
	Height entities.Length
}

type Margin struct {
	Top    entities.Length
	Right  entities.Length
	Bottom entities.Length
	Left   entities.Length
}

type MarginNotes struct {
	Width     entities.Length
	Separator entities.Length
	Placement string
}

type DebugOptions struct {
	Enabled bool

	HighlightLinks  bool
	HighlightFrames bool
}
