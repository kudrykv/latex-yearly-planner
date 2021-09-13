package compose

import (
	"fmt"
	"strconv"

	"github.com/kudrykv/latex-yearly-planner/app/components/header"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func HeaderTodosIndexed(cfg config.Config, tpls []string) (page.Modules, error) {
	if len(tpls) != 1 {
		return nil, fmt.Errorf("exppected two tpls, got %d %v", len(tpls), tpls)
	}

	modules := make(page.Modules, 0, 101)
	modules = append(modules, page.Module{
		Cfg: cfg,
		Tpl: tpls[0],
		Body: header.Header{
			Left: header.Items{
				header.NewIntItem(cfg.Year),
				header.NewTextItem("Todos Index").Ref(true),
			},
			Right: header.Items{
				header.NewTextItem("Notes").RefText("Notes Index"),
			},
		},
	})

	for i := 1; i <= 100; i++ {
		right := header.Items{}

		if i > 2 {
			right = append(right, header.NewTextItem("Todo "+strconv.Itoa(i-1)))
		}

		if i < 100 {
			right = append(right, header.NewTextItem("Todo "+strconv.Itoa(i+1)))
		}

		modules = append(modules, page.Module{
			Cfg: cfg,
			Tpl: tpls[0],
			Body: header.Header{
				Left: header.Items{
					header.NewIntItem(cfg.Year),
					header.NewTextItem("Todos Index"),
					header.NewTextItem("Todo " + strconv.Itoa(i)).Ref(true),
				},
				Right: right,
			},
		})
	}

	return modules, nil
}
