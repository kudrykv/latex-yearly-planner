package mosbodymonthly

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosmonthly"
	"github.com/kudrykv/latex-yearly-planner/internal/core/calendar"
)

type Body struct {
	notes Notes
}

func New(notes Notes) Body {
	return Body{
		notes: notes,
	}
}

func (r Body) GenerateComponent(_ context.Context, _ calendar.Month, _ mosmonthly.SectionParameters) ([]byte, error) {
	return []byte("body"), nil
}
