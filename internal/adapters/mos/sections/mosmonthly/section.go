package mosmonthly

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos"
	"github.com/kudrykv/latex-yearly-planner/internal/core/entities"
)

type SectionParameters struct {
	Enabled bool
}

type Section struct {
	globalParameters mos.Parameters
	parameters       SectionParameters
}

func New(globalParameters mos.Parameters, parameters SectionParameters) Section {
	return Section{globalParameters: globalParameters, parameters: parameters}
}

func (r Section) IsEnabled() bool {
	return r.parameters.Enabled
}

func (r Section) GenerateSection(ctx context.Context) (entities.Note, error) {
	return entities.Note{
		Name:     "monthly.tex",
		Contents: []byte(`\section{Monthly}`),
	}, nil
}
