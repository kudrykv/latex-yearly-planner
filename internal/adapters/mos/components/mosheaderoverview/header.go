package mosheaderoverview

import (
	"bytes"
	"context"
	_ "embed"
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosannual"
	"text/template"
)

//go:embed header_template.tex
var headerTemplate string

type Header struct {
	templateTree *template.Template
	global       mos.Parameters
}

func New(global mos.Parameters) (Header, error) {
	templateTree, err := template.New("mosheaderoverview").Parse(headerTemplate)
	if err != nil {
		return Header{}, fmt.Errorf("parse: %w", err)
	}

	return Header{
		templateTree: templateTree,
		global:       global,
	}, nil
}

func (r Header) GenerateComponent(
	_ context.Context, _ mosannual.PageNumber, _ mosannual.SectionParameters,
) ([]byte, error) {
	buffer := bytes.NewBuffer(nil)

	if err := r.templateTree.Execute(buffer, nil); err != nil {
		return nil, fmt.Errorf("execute: %w", err)
	}

	return buffer.Bytes(), nil
}
