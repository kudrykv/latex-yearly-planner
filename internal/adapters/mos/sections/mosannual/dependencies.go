package mosannual

import (
	"context"
)

type Component interface {
	GenerateComponent(context.Context) ([]byte, error)
}
