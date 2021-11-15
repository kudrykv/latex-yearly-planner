package header

import (
	"strconv"

	"github.com/kudrykv/latex-yearly-planner/app/components/hyper"
)

type IntItem struct {
	Val int
	ref bool
}

func (i IntItem) Display() string {
	var out string
	s := strconv.Itoa(i.Val)

	if i.ref {
		out = hyper.Target(s, s)
	} else {
		out = hyper.Link(s, s)
	}

	return out
}

func (i IntItem) Ref() IntItem {
	i.ref = true

	return i
}

func NewIntItem(val int) IntItem {
	return IntItem{Val: val}
}
