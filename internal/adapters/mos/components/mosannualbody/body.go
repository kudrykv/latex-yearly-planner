package mosannualbody

import (
	"bytes"
	"context"
	_ "embed"
	"fmt"
	"text/template"
)

//go:embed body_template.tex
var bodyTemplate string

type Body struct {
	templateTree *template.Template
}

func New() (Body, error) {
	templateTree, err := template.New("mosbodyoverview").Parse(bodyTemplate)
	if err != nil {
		return Body{}, fmt.Errorf("parse: %w", err)
	}

	return Body{
		templateTree: templateTree,
	}, nil
}

func (r Body) GenerateComponent(_ context.Context) ([]byte, error) {
	buffer := bytes.NewBuffer(nil)

	if err := r.templateTree.Execute(buffer, nil); err != nil {
		return nil, fmt.Errorf("execute: %w", err)
	}

	return buffer.Bytes(), nil
}
