package mosweekly

import (
	"bytes"
	"context"
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos"
	"github.com/kudrykv/latex-yearly-planner/internal/core/entities"
)

type SectionParameters struct {
	Enabled bool
}

type Section struct {
	globalParameters mos.Parameters
	parameters       SectionParameters

	header Component
	body   Component
}

func New(globalParameters mos.Parameters, parameters SectionParameters, header, body Component) Section {
	return Section{
		globalParameters: globalParameters,
		parameters:       parameters,

		header: header,
		body:   body,
	}
}

func (r Section) IsEnabled() bool {
	return r.parameters.Enabled
}

func (r Section) GenerateSection(ctx context.Context) (entities.Note, error) {
	buffer := bytes.NewBuffer(nil)

	for _, week := range r.globalParameters.Months.Weeks() {
		headerBytes, err := r.header.GenerateComponent(ctx, week, r.parameters)
		if err != nil {
			return entities.Note{}, fmt.Errorf("make header: %w", err)
		}

		buffer.Write(headerBytes)

		bodyBytes, err := r.body.GenerateComponent(ctx, week, r.parameters)
		if err != nil {
			return entities.Note{}, fmt.Errorf("make body: %w", err)
		}

		buffer.Write(bodyBytes)

		buffer.WriteString("\n" + `\pagebreak{}` + "\n\n")
	}

	return entities.Note{
		Name:     "weekly.tex",
		Contents: buffer.Bytes(),
	}, nil
}
