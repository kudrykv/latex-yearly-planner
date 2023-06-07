package mosdailybody

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosdaily"
	"github.com/kudrykv/latex-yearly-planner/internal/core/calendar"
	"strconv"
)

type Body struct {
	notes Notes
}

func New(notes Notes) Body {
	return Body{
		notes: notes,
	}
}

func (r Body) GenerateComponent(_ context.Context, day calendar.Day, _ mosdaily.SectionParameters) ([]byte, error) {
	return []byte(strconv.Itoa(day.Day())), nil
}
