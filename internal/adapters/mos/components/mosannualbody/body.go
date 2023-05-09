package mosannualbody

import (
	"bytes"
	"context"
	_ "embed"
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosannual"
	"text/template"
)

//go:embed body_template.tex
var bodyTemplate string

type Body struct {
	templateTree *template.Template
	global       mos.Parameters
}

func New(global mos.Parameters) (Body, error) {
	templateTree, err := template.New("mosbodyoverview").Parse(bodyTemplate)
	if err != nil {
		return Body{}, fmt.Errorf("parse: %w", err)
	}

	return Body{
		templateTree: templateTree,

		global: global,
	}, nil
}

func (r Body) GenerateComponent(
	_ context.Context, _ mosannual.PageNumber, _ mos.Parameters, _ mosannual.SectionParameters,
) ([]byte, error) {
	buffer := bytes.NewBuffer(nil)

	if err := r.templateTree.Execute(buffer, nil); err != nil {
		return nil, fmt.Errorf("execute: %w", err)
	}

	return buffer.Bytes(), nil
}
