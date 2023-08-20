package mostitles

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/core/entities"
)

type TitleParameters struct {
	IsEnabled bool

	Name string
}

type Title struct {
	parameters TitleParameters
}

func New(parameters TitleParameters) Title {
	return Title{parameters: parameters}
}

func (r Title) IsEnabled() bool {
	return r.parameters.IsEnabled
}

func (r Title) GenerateSection(_ context.Context) (entities.Note, error) {
	return entities.Note{
		Name:     "title.tex",
		Contents: []byte(r.parameters.Name),
	}, nil
}
