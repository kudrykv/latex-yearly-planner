package compose

import (
	"strconv"

	"github.com/kudrykv/latex-yearly-planner/app/components/header"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func TodosIndexed(cfg config.Config) []page.Page {
	pages := make([]page.Page, 0, 101)

	pages = append(pages, todosIndexPage(cfg))

	for i := 1; i <= 100; i++ {
		pages = append(pages, page.Page{
			Tpl: cfg.Blocks.TodosIndexed.TplPage,
			Header: header.Header{
				Left: header.Items{
					header.NewIntItem(cfg.Year),
					header.NewTextItem("Todos Index"),
					header.NewTextItem("Todo " + strconv.Itoa(i)).Ref(true),
				},
			},
		})
	}

	return pages
}

func todosIndexPage(cfg config.Config) page.Page {
	notesMatrix := make([][]int, 0, 10)

	for i := 1; i <= 10; i++ {
		notesRow := make([]int, 0, 10)

		for j := 1; j <= 10; j++ {
			notesRow = append(notesRow, (i-1)*10+j)
		}

		notesMatrix = append(notesMatrix, notesRow)
	}

	return page.Page{
		Tpl:    cfg.Blocks.TodosIndexed.TplIndex,
		Header: header.Header{},
		Body:   notesMatrix,
	}
}
