package texindexer

import (
	"bytes"
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners/entities"
)

type TeXIndexer struct{}

func New() TeXIndexer {
	return TeXIndexer{}
}

func (r TeXIndexer) CreateIndex(_ context.Context, files entities.Files) (entities.File, error) {
	buffer := bytes.NewBuffer(nil)

	for _, file := range files {
		buffer.WriteString(`\include{`)
		buffer.WriteString(file.Name)
		buffer.WriteString(`}`)
		buffer.WriteString("\n")
	}

	return entities.File{
		Name:     "index.tex",
		Contents: buffer.Bytes(),
	}, nil
}
