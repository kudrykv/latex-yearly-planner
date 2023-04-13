package planner

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planner/entities"
)

type Builder interface {
	Generate(context.Context) (entities.FileStructure, error)
}

type FileWriter interface {
	Write(context.Context, entities.File) error
}
