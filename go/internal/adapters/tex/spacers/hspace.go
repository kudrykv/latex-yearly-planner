package spacers

import "github.com/kudrykv/latex-yearly-planner/internal/core/entities"

type HSpace struct {
	Length entities.Length
}

func NewHSpace(length entities.Length) *HSpace {
	return &HSpace{
		Length: length,
	}
}

func (h *HSpace) String() string {
	if h.Length.IsSpecial() {
		return h.Length.String()
	}

	return `\hspace{` + h.Length.String() + `}`
}
