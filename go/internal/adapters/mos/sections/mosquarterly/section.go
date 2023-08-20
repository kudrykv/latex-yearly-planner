package mosquarterly

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

	CalendarsColumn          entities.Placement
	CalendarsColumnWidth     entities.Length
	ColumnHeight             entities.Length
	CalendarsVerticalSpacing entities.Length
	NotesColumnWidth         entities.Length
	ColumnSpacing            entities.Length
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
	buffer := bytes.NewBuffer(nil)

	numberOfMonths := len(r.globalParameters.Months)

	for quarter := 1; quarter <= numberOfMonths; quarter += 3 {
		from := quarter - 1
		to := quarter + 2
		if to > numberOfMonths {
			to = numberOfMonths
		}

		months := r.globalParameters.Months[from:to]

		headerBytes, err := r.header.GenerateComponent(ctx, months, r.parameters)
		if err != nil {
			return entities.Note{}, fmt.Errorf("make header at q %d: %w", quarter, err)
		}

		bodyBytes, err := r.body.GenerateComponent(ctx, months, r.parameters)
		if err != nil {
			return entities.Note{}, fmt.Errorf("make body at q %d: %w", quarter, err)
		}

		buffer.Write(headerBytes)
		buffer.Write(bodyBytes)
		buffer.WriteString(`{}\pagebreak{}` + "\n\n")
	}

	return entities.Note{
		Name:     "quarterly.tex",
		Contents: buffer.Bytes(),
	}, nil
}
