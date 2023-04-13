package mos

import (
	"context"
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners/entities"
)

type MOS struct {
	sections Sections
}

func New(sections Sections) *MOS {
	return &MOS{sections: sections}
}

type Sections []Section
type Section struct {
	Enabled bool
}

func (r Section) IsEnabled() bool {
	return r.Enabled
}

func (r Section) Generate(_ context.Context) (entities.File, error) {
	panic("not implemented")
}

func (r MOS) Generate(ctx context.Context) (entities.FileStructure, error) {
	// generate title, calendar, quarterly and monthly pages, etc
	// generate an index document for the whole planner
	// and return the file structure

	// sections:
	// - title
	// - annual calendar
	// - quarterly pages
	// - monthly pages
	// - weekly pages
	// - daily pages
	// - daily notes
	// - daily reflections
	// - index for note pages
	// - note pages
	// - index for to-do pages
	// - to-do pages

	// as all sections should be connected with each other in some form, all those dates, months, etc.,
	// they need to have a predictive reference
	// in the same time if some section is disabled, we should not link to it
	//
	// also keeping in mind that if we're referring to e.g., a monthly page, that dedicated page must exist
	// or, if we link to a reflection for a date, that page must exist, too
	// like, a target isn't just a piece of text somewhere, but the whole dedicated page

	fileStructure := entities.FileStructure{}

	for _, section := range r.sections {
		if !section.IsEnabled() {
			continue
		}

		file, err := section.Generate(ctx)
		if err != nil {
			return fileStructure, fmt.Errorf("generate section: %w", err)
		}

		fileStructure.Files = append(fileStructure.Files, file)
	}

	return fileStructure, nil
}
