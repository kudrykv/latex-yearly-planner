package mosannual

import (
	"bytes"
	"context"
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos"
	"github.com/kudrykv/latex-yearly-planner/internal/core/entities"
)

type Section struct {
	globalParameters mos.Parameters
	parameters       SectionParameters

	header Component
	body   Component
}

type SectionParameters struct {
	Enabled bool
}

func New(global mos.Parameters, local SectionParameters, header, body Component) Section {
	return Section{
		globalParameters: global,
		parameters:       local,

		header: header,
		body:   body,
	}
}

func (r Section) IsEnabled() bool {
	return r.parameters.Enabled
}

func (r Section) GenerateSection(ctx context.Context) (entities.Note, error) {
	headerBytes, err := r.makeHeader(ctx)
	if err != nil {
		return entities.Note{}, fmt.Errorf("make header: %w", err)
	}

	bodyBytes, err := r.makeBody(ctx)
	if err != nil {
		return entities.Note{}, fmt.Errorf("make body: %w", err)
	}

	buffer := bytes.NewBuffer(headerBytes)
	buffer.Write(bodyBytes)

	return entities.Note{
		Name:     "annual.tex",
		Contents: buffer.Bytes(),
	}, nil
}

func (r Section) makeHeader(ctx context.Context) ([]byte, error) {
	componentBytes, err := r.header.GenerateComponent(ctx)
	if err != nil {
		return nil, fmt.Errorf("generate header: %w", err)
	}

	return componentBytes, nil
}

func (r Section) makeBody(ctx context.Context) ([]byte, error) {
	componentBytes, err := r.body.GenerateComponent(ctx)
	if err != nil {
		return nil, fmt.Errorf("generate body: %w", err)
	}

	return componentBytes, nil
}
