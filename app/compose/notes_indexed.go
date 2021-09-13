package compose

import (
	"fmt"

	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func NotesIndexed(cfg config.Config, tpls []string) (page.Modules, error) {
	if len(tpls) != 2 {
		return nil, fmt.Errorf("exppected two tpls, got %d %v", len(tpls), tpls)
	}

	modules := make(page.Modules, 0, 101)

	modules = append(modules, notesIndexPage(cfg, tpls[0]))

	for i := 1; i <= 100; i++ {
		modules = append(modules, page.Module{Cfg: cfg, Tpl: tpls[1]})
	}

	return modules, nil
}

func notesIndexPage(cfg config.Config, tpl string) page.Module {
	notesMatrix := make([][]int, 0, 10)

	for i := 1; i <= 10; i++ {
		notesRow := make([]int, 0, 10)

		for j := 1; j <= 10; j++ {
			notesRow = append(notesRow, (i-1)*10+j)
		}

		notesMatrix = append(notesMatrix, notesRow)
	}

	return page.Module{Cfg: cfg, Tpl: tpl, Body: notesMatrix}
}
