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
	return entities.Note{}, fmt.Errorf("not implemented")
}
