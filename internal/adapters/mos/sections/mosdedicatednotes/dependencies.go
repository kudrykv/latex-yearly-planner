package mosdedicatednotes

import (
	"context"
)

type Component interface {
	GenerateForDedicatedNotesIndexPage(context.Context, SectionParameters, int) ([]byte, error)
	GenerateForDedicatedNotesPage(context.Context, SectionParameters, int, int) ([]byte, error)
}
