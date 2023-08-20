package planners

import (
	"context"
	entities2 "github.com/kudrykv/latex-yearly-planner/internal/core/entities"
)

//go:generate mockgen -source=dependencies.go -destination=mocks/dependencies.go -package=mocks

type (
	CommandName = string
	BasePath    = string
	StringArg   = string
)

type PlannerBuilder interface {
	Generate(context.Context) (entities2.NoteStructure, error)
}

type NoteWriter interface {
	Write(context.Context, entities2.Note) error
}

type Commander interface {
	Run(context.Context, CommandName, ...StringArg) error
}
