package planners

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners/entities"
)

//go:generate mockery --all --case=underscore

type Builder interface {
	Generate(context.Context) (entities.FileStructure, error)
}

type FileWriter interface {
	Write(context.Context, entities.File) error
}
