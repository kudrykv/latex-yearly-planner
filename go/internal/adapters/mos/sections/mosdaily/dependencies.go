package mosdaily

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/core/calendar"
)

type Component interface {
	GenerateComponent(context.Context, calendar.Day, SectionParameters) ([]byte, error)
}
