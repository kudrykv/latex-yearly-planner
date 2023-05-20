package noting

import "github.com/kudrykv/latex-yearly-planner/internal/core/entities"

type Notes struct {
	pattern Pattern
}

func New(pattern Pattern) Notes {
	return Notes{
		pattern: pattern,
	}
}

func (r Notes) Render(width, height entities.Length) string {
	return r.pattern.Render(width, height)
}
