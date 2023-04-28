package mosannual

import (
	"context"
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/internal/core/entities"
)

type Section struct {
	parameters SectionParameters
}

type SectionParameters struct {
	Enabled bool
}

func New(parameters SectionParameters) Section {
	return Section{parameters: parameters}
}

func (r Section) IsEnabled() bool {
	return r.parameters.Enabled
}

func (r Section) GenerateSection(_ context.Context) (entities.Note, error) {
	return entities.Note{}, fmt.Errorf("not implemented")
}
