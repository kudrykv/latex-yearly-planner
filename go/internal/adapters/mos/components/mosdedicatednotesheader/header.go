package mosdedicatednotesheader

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosdedicatednotes"
	"strconv"
)

type Header struct{}

func New() Header {
	return Header{}
}

func (r Header) GenerateForDedicatedNotesIndexPage(ctx context.Context, parameters mosdedicatednotes.SectionParameters, indexPageNumber int) ([]byte, error) {
	return []byte("header - " + strconv.Itoa(indexPageNumber)), nil
}

func (r Header) GenerateForDedicatedNotesPage(ctx context.Context, parameters mosdedicatednotes.SectionParameters, noteNumber int, page int) ([]byte, error) {
	return []byte("header - " + strconv.Itoa(noteNumber) + " - " + strconv.Itoa(page)), nil
}
