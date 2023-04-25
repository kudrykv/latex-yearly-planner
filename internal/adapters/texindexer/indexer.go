package texindexer

import (
	"bytes"
	"context"
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners/entities"
	"strings"
	"text/template"
)

type TeXIndexer struct {
	templateTree *template.Template
}

func New(templateText string) (TeXIndexer, error) {
	templateTree := template.New("index")

	var err error
	if templateTree, err = templateTree.Parse(templateText); err != nil {
		return TeXIndexer{}, fmt.Errorf("parse template: %w", err)
	}

	return TeXIndexer{
		templateTree: templateTree,
	}, nil
}

func (r TeXIndexer) CreateIndex(_ context.Context, files entities.Notes) (entities.Note, error) {
	buffer := bytes.NewBuffer(nil)

	if err := r.templateTree.Execute(buffer, map[string]any{"Notes": r.files(files)}); err != nil {
		return entities.Note{}, fmt.Errorf("execute template: %w", err)
	}

	return entities.Note{
		Name:     "index.tex",
		Contents: buffer.Bytes(),
	}, nil
}

func (r TeXIndexer) files(files entities.Notes) string {
	buffer := bytes.NewBuffer(nil)

	fileNames := make([]string, 0, len(files))

	for _, file := range files {
		fileNames = append(fileNames, `\include{`+file.Name+`}`)
	}

	buffer.WriteString(strings.Join(fileNames, "\n"))

	return buffer.String()
}
