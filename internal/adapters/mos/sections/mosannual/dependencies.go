package mosannual

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos"
)

type PageNumber = int

type Component interface {
	GenerateComponent(context.Context, PageNumber, mos.Parameters, SectionParameters) ([]byte, error)
}
