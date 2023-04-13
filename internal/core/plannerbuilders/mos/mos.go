package mos

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners/entities"
)

type MOS struct{}

func (r MOS) Generate(_ context.Context) (entities.FileStructure, error) {
	panic("not implemented")
}
