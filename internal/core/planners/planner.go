package planners

import (
	"context"
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners/entities"
)

type Planner struct {
	builder    PlannerBuilder
	noteWriter NoteWriter
	commander  Commander

	fileStructure entities.NoteStructure
}

func New(builder PlannerBuilder, noteWriter NoteWriter, commander Commander) *Planner {
	return &Planner{
		builder:    builder,
		noteWriter: noteWriter,
		commander:  commander,
	}
}

func (r *Planner) Generate(ctx context.Context) error {
	var err error
	if r.fileStructure, err = r.builder.Generate(ctx); err != nil {
		return fmt.Errorf("generate: %w", err)
	}

	return nil
}

func (r *Planner) Write(ctx context.Context) error {
	if r.fileStructure.IsEmpty() {
		return fmt.Errorf("nothing has been generated: %w", ErrNothingToWrite)
	}

	if err := r.noteWriter.Write(ctx, r.fileStructure.Index); err != nil {
		return fmt.Errorf("write index: %w", err)
	}

	for _, file := range r.fileStructure.Notes {
		if err := r.noteWriter.Write(ctx, file); err != nil {
			return fmt.Errorf("write file: %w", err)
		}
	}

	return nil
}

func (r *Planner) Compile(ctx context.Context) error {
	if r.fileStructure.IsEmpty() {
		return fmt.Errorf("nothing has been generated: %w", ErrNothingToCompile)
	}

	if err := r.commander.Run(ctx, "pdflatex", r.fileStructure.Index.Name); err != nil {
		return fmt.Errorf("compile index: %w", err)
	}

	return nil
}
