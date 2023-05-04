package mosheaderoverview

import (
	"bytes"
	"context"
	_ "embed"
	"fmt"
	"text/template"
)

//go:embed header_template.tex
var headerTemplate string

type Header struct {
	templateTree *template.Template
}

func New() (Header, error) {
	templateTree, err := template.New("mosheaderoverview").Parse(headerTemplate)
	if err != nil {
		return Header{}, fmt.Errorf("parse: %w", err)
	}

	return Header{
		templateTree: templateTree,
	}, nil
}

func (r Header) GenerateComponent(_ context.Context) ([]byte, error) {
	buffer := bytes.NewBuffer(nil)

	if err := r.templateTree.Execute(buffer, nil); err != nil {
		return nil, fmt.Errorf("execute: %w", err)
	}

	return buffer.Bytes(), nil
}
