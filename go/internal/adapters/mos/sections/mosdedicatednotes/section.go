package mosdedicatednotes

import (
	"bytes"
	"context"
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos"
	"github.com/kudrykv/latex-yearly-planner/internal/core/entities"
)

type SectionParameters struct {
	Enabled           bool
	IndexPages        int
	NotesPerIndexPage int
	NotesNumber       int
	PagesPerNote      int
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

	for indexPage := 1; indexPage <= r.parameters.IndexPages; indexPage++ {
		headerBytes, err := r.header.GenerateForDedicatedNotesIndexPage(ctx, r.parameters, indexPage)
		if err != nil {
			return entities.Note{}, fmt.Errorf("make header: %w", err)
		}

		buffer.Write(headerBytes)

		bodyBytes, err := r.body.GenerateForDedicatedNotesIndexPage(ctx, r.parameters, indexPage)
		if err != nil {
			return entities.Note{}, fmt.Errorf("make body: %w", err)
		}

		buffer.Write(bodyBytes)
		buffer.WriteString("\n" + `\pagebreak{}` + "\n\n")
	}

	for noteNumber := 1; noteNumber <= r.parameters.NotesNumber; noteNumber++ {
		for page := 1; page <= r.parameters.PagesPerNote; page++ {
			headerBytes, err := r.header.GenerateForDedicatedNotesPage(ctx, r.parameters, noteNumber, page)
			if err != nil {
				return entities.Note{}, fmt.Errorf("make header: %w", err)
			}

			buffer.Write(headerBytes)

			bodyBytes, err := r.body.GenerateForDedicatedNotesPage(ctx, r.parameters, noteNumber, page)
			if err != nil {
				return entities.Note{}, fmt.Errorf("make body: %w", err)
			}

			buffer.Write(bodyBytes)
			buffer.WriteString("\n" + `\pagebreak{}` + "\n\n")
		}
	}

	return entities.Note{
		Name:     "dedicated_notes.tex",
		Contents: buffer.Bytes(),
	}, nil
}
