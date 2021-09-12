package compose

import (
	"fmt"
	"strconv"

	"github.com/kudrykv/latex-yearly-planner/app/components/header"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func NotesIndexed(cfg config.Config, tpls []string) ([]page.Page, error) {
	if len(tpls) != 2 {
		return nil, fmt.Errorf("exppected two tpls, got %d %v", len(tpls), tpls)
	}

	pages := make([]page.Page, 0, 101)

	pages = append(pages, notesIndexPage(cfg, tpls[0]))

	for i := 1; i <= 100; i++ {
		right := header.Items{}

		if i > 2 {
			right = append(right, header.NewTextItem("Note "+strconv.Itoa(i-1)))
		}

		if i < 100 {
			right = append(right, header.NewTextItem("Note "+strconv.Itoa(i+1)))
		}

		pages = append(pages, page.Page{
			Tpl: tpls[1],
			Header: header.Header{
				Left: header.Items{
					header.NewIntItem(cfg.Year),
					header.NewTextItem("Notes Index"),
					header.NewTextItem("Note " + strconv.Itoa(i)).Ref(true),
				},
				Right: right,
			},
		})
	}

	return pages, nil
}

func notesIndexPage(cfg config.Config, tpl string) page.Page {
	notesMatrix := make([][]int, 0, 10)

	for i := 1; i <= 10; i++ {
		notesRow := make([]int, 0, 10)

		for j := 1; j <= 10; j++ {
			notesRow = append(notesRow, (i-1)*10+j)
		}

		notesMatrix = append(notesMatrix, notesRow)
	}

	return page.Page{
		Tpl: tpl,
		Header: header.Header{
			Left: header.Items{
				header.NewIntItem(cfg.Year),
				header.NewTextItem("Notes Index").Ref(true),
			},
			Right: header.Items{
				header.NewTextItem("Todos").RefText("Todos Index"),
			},
		},
		Body: notesMatrix,
	}
}
