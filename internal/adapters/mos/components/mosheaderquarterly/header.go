package mosheaderquarterly

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosquarterly"
	"github.com/kudrykv/latex-yearly-planner/internal/core/calendar"
)

type Header struct{}

func New() Header {
	return Header{}
}

func (r Header) GenerateComponent(_ context.Context, _ calendar.Months, _ mosquarterly.SectionParameters) ([]byte, error) {
	return []byte(`quarterly header`), nil
}
