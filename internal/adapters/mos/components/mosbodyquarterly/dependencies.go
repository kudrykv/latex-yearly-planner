package mosbodyquarterly

import "github.com/kudrykv/latex-yearly-planner/internal/core/entities"

type Notes interface {
	Render(width entities.Length, height entities.Length) string
}
