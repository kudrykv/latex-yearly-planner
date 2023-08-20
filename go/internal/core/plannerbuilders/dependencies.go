package plannerbuilders

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/core/entities"
)

//go:generate mockgen -source=dependencies.go -destination=mocks/dependencies.go -package=mocks

type Sections []Section

type Section interface {
	IsEnabled() bool
	GenerateSection(context.Context) (entities.Note, error)
}

type Indexer interface {
	CreateIndex(context.Context, entities.Notes) (entities.Note, error)
}
