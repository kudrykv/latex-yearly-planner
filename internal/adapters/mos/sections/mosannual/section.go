package mosannual

import (
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
	if err := r.makeHeader(); err != nil {
		return entities.Note{}, fmt.Errorf("make header: %w", err)
	}

	if err := r.makeBody(); err != nil {
		return entities.Note{}, fmt.Errorf("make body: %w", err)
	}

	note, err := r.makeNote()
	if err != nil {
		return entities.Note{}, fmt.Errorf("make note: %w", err)
	}

	return note, nil
}

func (r Section) makeHeader() error {
	return fmt.Errorf("not implemented")
}

func (r Section) makeBody() error {
	return fmt.Errorf("not implemented")
}

func (r Section) makeNote() (entities.Note, error) {
	return entities.Note{}, fmt.Errorf("not implemented")
}
