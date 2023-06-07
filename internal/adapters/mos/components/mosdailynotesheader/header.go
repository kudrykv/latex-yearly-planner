package mosdailynotesheader

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosdailynotes"
	"github.com/kudrykv/latex-yearly-planner/internal/core/calendar"
)

type Header struct{}

func New() Header {
	return Header{}
}

func (r Header) GenerateComponent(_ context.Context, _ calendar.Day, _ mosdailynotes.SectionParameters) ([]byte, error) {
	return []byte{}, nil
}
