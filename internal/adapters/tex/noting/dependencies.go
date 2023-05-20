package noting

import (
	"github.com/kudrykv/latex-yearly-planner/internal/core/entities"
)

type Width = entities.Length
type Height = entities.Length

type Pattern interface {
	Render(Width, Height) string
}
