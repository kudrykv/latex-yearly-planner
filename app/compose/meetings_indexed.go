package compose

import (
	"fmt"

	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func MeetingsIndexed(cfg config.Config, tpls []string) (page.Modules, error) {
	if len(tpls) != 2 {
		return nil, fmt.Errorf("exppected two tpls, got %d %v", len(tpls), tpls)
	}

	numbers := make([]int, 0, 35)
	for i := 1; i <= cfg.Layout.Numbers.IndexMeetingNotes; i++ {
		numbers = append(numbers, i)
	}

	modules := make(page.Modules, 0, 101)
	modules = append(modules, page.Module{Cfg: cfg, Tpl: tpls[0], Body: numbers})

	for i := 1; i <= cfg.Layout.Numbers.IndexMeetingNotes; i++ {
		modules = append(modules, page.Module{Cfg: cfg, Tpl: tpls[1]})
	}

	return modules, nil
}
