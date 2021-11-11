package note

import (
	"fmt"
	"strconv"

	"github.com/kudrykv/latex-yearly-planner/app/components/header"
	"github.com/kudrykv/latex-yearly-planner/app/components/hyper"
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

func (p Notes) HeadingMOS() string {
	return `\begin{tabular}{@{}l}` +
		hyper.Target("Notes Index", "") + `\resizebox{!}{\myLenHeaderResizeBox}{Index Notes\myDummyQ}
\end{tabular}`
}

func (n Note) HyperLink() string {
	return hyper.Link(n.ref(), fmt.Sprintf("%02d", n.Number))
}

func (n Note) Breadcrumb() string {
	return header.Items{
		header.NewIntItem(n.Year),
		header.NewTextItem("Notes Index"),
		header.NewTextItem(n.ref()).Ref(true),
	}.Table(true)
}

func (n Note) PrevNext() header.Items {
	items := header.Items{}

	if n.Number > 1 {
		items = append(items, header.NewTextItem("Note "+strconv.Itoa(n.Number-1)))
	}

	return items
}

func (n Note) HeadingMOS() string {
	num := strconv.Itoa(n.Number)
	return `\begin{tabular}{@{}l}` +
		hyper.Target(n.ref(), "") + `\resizebox{!}{\myLenHeaderResizeBox}{Note ` + num + `\myDummyQ}
\end{tabular}`
}

func (n Note) ref() string {
	return "Note " + strconv.Itoa(n.Number)
}
