package mosdocument

import (
	_ "embed"
	"fmt"
	"strings"
	"text/template"
)

//go:embed document_template.tex
var documentTemplate string

type DocumentParameters struct{}

type Document struct {
	templateTree *template.Template
	parameters   DocumentParameters
}

func New(parameters DocumentParameters) (Document, error) {
	templateTree, err := template.New("document").Parse(documentTemplate)
	if err != nil {
		return Document{}, fmt.Errorf("parse: %w", err)
	}

	return Document{
		templateTree: templateTree,
		parameters:   parameters,
	}, nil
}

func (r Document) Execute() (string, error) {
	builder := &strings.Builder{}

	if err := r.templateTree.Execute(builder, r.parameters); err != nil {
		return "", fmt.Errorf("execute: %w", err)
	}

	return builder.String(), nil
}
