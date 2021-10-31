package note

import (
	"strconv"

	"github.com/kudrykv/latex-yearly-planner/app/components/header"
)

type Notes []*Note
type Note struct {
	Number int
}

func NewNote(number int) *Note {
	return &Note{Number: number}
}

func (p Notes) Breadcrumb(year, idx int) string {
	postfix := ""
	if idx > 0 {
		postfix = " " + strconv.Itoa(idx+1)
	}

	return header.Items{
		header.NewIntItem(year),
		header.NewTextItem("Notes Index" + postfix).Ref(true),
	}.Table(true)
}
