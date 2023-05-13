package spacer

import "github.com/kudrykv/latex-yearly-planner/internal/core/entities"

type VSpace struct {
	Length entities.Length
}

func NewVSpace(length entities.Length) VSpace {
	return VSpace{Length: length}
}

func (v VSpace) String() string {
	if v.Length.IsSpecial() {
		return v.Length.String()
	}

	return `\vspace{` + v.Length.String() + `}`
}
