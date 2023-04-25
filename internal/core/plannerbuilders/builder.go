package plannerbuilders

import (
	"context"
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners/entities"
)

type Builder struct {
	sections Sections
	indexer  Indexer
}

func New(indexer Indexer, sections Sections) *Builder {
	return &Builder{
		indexer:  indexer,
		sections: sections,
	}
}

func (r *Builder) Generate(ctx context.Context) (entities.NoteStructure, error) {
	fileStructure := entities.NoteStructure{}

	for _, section := range r.sections {
		if !section.IsEnabled() {
			continue
		}

		file, err := section.GenerateSection(ctx)
		if err != nil {
			return fileStructure, fmt.Errorf("generate section: %w", err)
		}

		fileStructure.Notes = append(fileStructure.Notes, file)
	}

	var err error
	if fileStructure.Index, err = r.indexer.CreateIndex(ctx, fileStructure.Notes); err != nil {
		return fileStructure, fmt.Errorf("create index: %w", err)
	}

	return fileStructure, nil
}
