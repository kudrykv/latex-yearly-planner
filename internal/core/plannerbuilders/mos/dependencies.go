package mos

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners/entities"
)

type Sections []Section

type Section interface {
	IsEnabled() bool
	GenerateSection(context.Context) (entities.File, error)
}

type Indexer interface {
	CreateIndex(context.Context, entities.Files) (entities.File, error)
}
