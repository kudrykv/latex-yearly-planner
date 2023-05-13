package mosquarterly

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/core/calendar"
)

type PageNumber = int

type Component interface {
	GenerateComponent(context.Context, calendar.Months, SectionParameters) ([]byte, error)
}
