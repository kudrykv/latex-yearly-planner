package mosquarterlybody

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosquarterly"
	"github.com/kudrykv/latex-yearly-planner/internal/core/calendar"
)

type Body struct{}

func New() Body {
	return Body{}
}

func (r Body) GenerateComponent(_ context.Context, _ calendar.Months, _ mosquarterly.SectionParameters) ([]byte, error) {
	return []byte(`quarterly body`), nil
}
