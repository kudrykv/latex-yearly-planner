package mosdedicatednotesbody

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosdedicatednotes"
	"strconv"
)

type Body struct{}

func New() Body {
	return Body{}
}

func (r Body) GenerateForDedicatedNotesIndexPage(ctx context.Context, parameters mosdedicatednotes.SectionParameters, indexPage int) ([]byte, error) {
	return []byte(`page - ` + strconv.Itoa(indexPage)), nil
}

func (r Body) GenerateForDedicatedNotesPage(ctx context.Context, parameters mosdedicatednotes.SectionParameters, noteNumber int, page int) ([]byte, error) {
	return []byte(`page - ` + strconv.Itoa(noteNumber) + " - " + strconv.Itoa(page)), nil
}
