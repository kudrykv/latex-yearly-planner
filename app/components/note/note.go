package note

import (
	"strconv"

	"github.com/kudrykv/latex-yearly-planner/app/components/header"
)

type Notes []*Note
type Note struct {
	Year   int
	Number int
}

func NewNote(year, number int) *Note {
	return &Note{Year: year, Number: number}
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

func (n Note) Breadcrumb() string {
	return header.Items{
		header.NewIntItem(n.Year),
		header.NewTextItem("Notes Index"),
		header.NewTextItem("Note " + strconv.Itoa(n.Number)).Ref(true),
	}.Table(true)
}

func (n Note) PrevNext() header.Items {
	items := header.Items{}

	if n.Number > 1 {
		items = append(items, header.NewTextItem("Note "+strconv.Itoa(n.Number-1)))
	}

	return items
}
