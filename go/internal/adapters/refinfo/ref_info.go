package refinfo

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/core/entities"
)

type RefInfo struct{}

func New() RefInfo {
	return RefInfo{}
}

func (r RefInfo) IsEnabled() bool {
	return true
}

func (r RefInfo) GenerateSection(_ context.Context) (entities.Note, error) {
	return entities.Note{
		Name:     "ref_info.tex",
		Contents: []byte("compiled with love"),
	}, nil
}
