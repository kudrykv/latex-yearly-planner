package planner

import (
	"context"
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planner/entities"
)

type Planner struct {
	builder    Builder
	fileWriter FileWriter

	fileStructure entities.FileStructure
}

func New(builder Builder, fileWriter FileWriter) Planner {
	return Planner{
		builder:    builder,
		fileWriter: fileWriter,
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

	if err := r.fileWriter.Write(ctx, r.fileStructure.Index); err != nil {
		return fmt.Errorf("write index: %w", err)
	}

	for _, file := range r.fileStructure.Files {
		if err := r.fileWriter.Write(ctx, file); err != nil {
			return fmt.Errorf("write file: %w", err)
		}
	}

	return nil
}

func (r *Planner) Compile() error {
	panic("not implemented")
}
