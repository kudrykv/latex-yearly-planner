package planners

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners/entities"
)

//go:generate mockgen -source=dependencies.go -destination=mocks/dependencies.go -package=mocks

type (
	CommandName = string
	BasePath    = string
)

type Builder interface {
	Generate(context.Context) (entities.FileStructure, error)
}

type FileWriter interface {
	Write(context.Context, BasePath, entities.File) error
}

type Commander interface {
	CreateCommand(CommandName, BasePath) Command
}

type Command interface {
	SetBasePath(path BasePath)
	Run(context.Context) error
}
