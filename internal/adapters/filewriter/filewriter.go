package filewriter

import (
	"context"
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners/entities"
	"os"
	"path"
)

type FileWriter struct {
	basePath string
}

func New(basePath string) FileWriter {
	return FileWriter{
		basePath: basePath,
	}
}

func (r FileWriter) Write(_ context.Context, note entities.Note) error {
	if err := os.WriteFile(path.Join(r.basePath, note.Name), note.Contents, 0644); err != nil {
		return fmt.Errorf("write file: %w", err)
	}

	return nil
}
