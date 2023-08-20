package mosannual

import (
	"context"
)

type PageNumber = int

type Component interface {
	GenerateComponent(context.Context, PageNumber, SectionParameters) ([]byte, error)
}
