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

type PlannerBuilder interface {
	Generate(context.Context) (entities.NoteStructure, error)
}

type NoteWriter interface {
	Write(context.Context, BasePath, entities.Note) error
}

type Commander interface {
	CreateCommand(CommandName, BasePath) Command
}

type Command interface {
	SetBasePath(path BasePath)
	Run(context.Context) error
}
