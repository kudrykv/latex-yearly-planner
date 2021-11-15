package note

import (
	"strconv"

	"github.com/kudrykv/latex-yearly-planner/app/components/header"
)

type Pages []Notes

type Index struct {
	Pages Pages
}

func NewIndex(year, notesOnPage, pages int) *Index {
	pgs := make(Pages, 0, pages)

	for pageNum := 1; pageNum <= pages; pageNum++ {
		pg := make(Notes, 0, notesOnPage)

		for noteNum := 1; noteNum <= notesOnPage; noteNum++ {
			pg = append(pg, NewNote(year, pageNum, (pageNum-1)*notesOnPage+noteNum))
		}

		pgs = append(pgs, pg)
	}

	return &Index{Pages: pgs}
}

func (i Index) PrevNext(currIdx int) header.Items {
	if len(i.Pages) <= 1 {
		return header.Items{}
	}

	list := header.Items{}

	if currIdx > 0 {
		postfix := " " + strconv.Itoa(currIdx)
		if currIdx == 1 {
			postfix = ""
		}

		list = append(list, header.NewTextItem("Notes Index"+postfix))
	}

	if currIdx+1 < len(i.Pages) {
		list = append(list, header.NewTextItem("Notes Index "+strconv.Itoa(currIdx+2)))
	}

	return list
}
