package mosweekly

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/core/calendar"
)

type Component interface {
	GenerateComponent(ctx context.Context, month calendar.Week, parameters SectionParameters) ([]byte, error)
}
