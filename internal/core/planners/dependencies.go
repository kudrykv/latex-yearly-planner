package planners

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners/entities"
)

//go:generate mockgen -source=dependencies.go -destination=mocks/dependencies.go -package=mocks

type (
	CommandName = string
	BasePath    = string
	StringArg   = string
)

type PlannerBuilder interface {
	Generate(context.Context) (entities.NoteStructure, error)
}

type NoteWriter interface {
	Write(context.Context, entities.Note) error
}

type Commander interface {
	Run(context.Context, CommandName, ...StringArg) error
}
