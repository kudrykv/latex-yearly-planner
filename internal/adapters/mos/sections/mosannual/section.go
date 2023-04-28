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
}

type SectionParameters struct {
	Enabled bool
}

func New(global mos.Parameters, local SectionParameters) Section {
	return Section{
		globalParameters: global,
		parameters:       local,
	}
}

func (r Section) IsEnabled() bool {
	return r.parameters.Enabled
}

func (r Section) GenerateSection(_ context.Context) (entities.Note, error) {
	headerBytes, err := r.makeHeader()
	if err != nil {
		return entities.Note{}, fmt.Errorf("make header: %w", err)
	}

	bodyBytes, err := r.makeBody()
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

func (r Section) makeHeader() ([]byte, error) {
	return nil, fmt.Errorf("not implemented")
}

func (r Section) makeBody() ([]byte, error) {
	return nil, fmt.Errorf("not implemented")
}
