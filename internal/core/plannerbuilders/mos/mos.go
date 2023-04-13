package mos

import (
	"context"
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners/entities"
)

type MOS struct {
	sections Sections
	indexer  Indexer
}

func New(sections Sections) *MOS {
	return &MOS{sections: sections}
}

func (r *MOS) Generate(ctx context.Context) (entities.FileStructure, error) {
	fileStructure := entities.FileStructure{}

	for _, section := range r.sections {
		if !section.IsEnabled() {
			continue
		}

		file, err := section.GenerateSection(ctx)
		if err != nil {
			return fileStructure, fmt.Errorf("generate section: %w", err)
		}

		fileStructure.Files = append(fileStructure.Files, file)
	}

	var err error
	if fileStructure.Index, err = r.indexer.CreateIndex(ctx, fileStructure.Files); err != nil {
		return fileStructure, fmt.Errorf("create index: %w", err)
	}

	return fileStructure, nil
}
