package planners

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners/entities"
)

//go:generate mockgen -source=dependencies.go -destination=mocks/dependencies.go -package=mocks

type Builder interface {
	Generate(context.Context) (entities.FileStructure, error)
}

type FileWriter interface {
	Write(context.Context, entities.File) error
}

type (
	CommandName = string
	BasePath    = string
)

type Commander interface {
	CreateCommand(CommandName, BasePath) Command
}

type Command interface {
	SetBasePath(path BasePath)
	Run(context.Context) error
}
