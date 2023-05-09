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
	Pages   int
}

func New(global mos.Parameters, local SectionParameters, header, body Component) (Section, error) {
	return Section{
		globalParameters: global,
		parameters:       local,

		header: header,
		body:   body,
	}, nil
}

func (r Section) IsEnabled() bool {
	return r.parameters.Enabled
}

func (r Section) GenerateSection(ctx context.Context) (entities.Note, error) {
	buffer := bytes.NewBuffer(nil)

	for pageNumber := 1; pageNumber <= r.parameters.Pages; pageNumber++ {
		headerBytes, err := r.header.GenerateComponent(ctx, pageNumber, r.globalParameters, r.parameters)
		if err != nil {
			return entities.Note{}, fmt.Errorf("make header at page %d: %w", pageNumber, err)
		}

		bodyBytes, err := r.body.GenerateComponent(ctx, pageNumber, r.globalParameters, r.parameters)
		if err != nil {
			return entities.Note{}, fmt.Errorf("make body at page %d: %w", pageNumber, err)
		}

		buffer.Write(headerBytes)
		buffer.Write(bodyBytes)
	}

	return entities.Note{
		Name:     "annual.tex",
		Contents: buffer.Bytes(),
	}, nil
}
