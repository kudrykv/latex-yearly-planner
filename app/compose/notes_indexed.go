package compose

import (
	"github.com/kudrykv/latex-yearly-planner/app/components/cal"
	"github.com/kudrykv/latex-yearly-planner/app/components/note"
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func NotesIndexed(cfg config.Config, tpls []string) (page.Modules, error) {
	index := note.NewIndex(cfg.Year, 35, 2)
	year := cal.NewYear(cfg.WeekStart, cfg.Year)
	modules := make(page.Modules, 0, 1)

	for idx, indexPage := range index.Pages {
		modules = append(modules, page.Module{
			Cfg: cfg,
			Tpl: tpls[0],
			Body: map[string]interface{}{
				"Notes":        indexPage,
				"Breadcrumb":   indexPage.Breadcrumb(cfg.Year, idx),
				"HeadingMOS":   indexPage.HeadingMOS(idx + 1),
				"SideQuarters": year.SideQuarters(0),
				"SideMonths":   year.SideMonths(0),
				"Extra":        index.PrevNext(idx),
				"Extra2":       extra2(false, true, nil),
			},
		})
	}

	for _, notes := range index.Pages {
		for _, nt := range notes {
			modules = append(modules, page.Module{
				Cfg: cfg,
				Tpl: tpls[1],
				Body: map[string]interface{}{
					"Note":         nt,
					"Breadcrumb":   nt.Breadcrumb(),
					"HeadingMOS":   nt.HeadingMOS(),
					"SideQuarters": year.SideQuarters(0),
					"SideMonths":   year.SideMonths(0),
					"Extra":        nt.PrevNext(),
					"Extra2":       extra2(false, false, nil),
				},
			})
		}
	}

	return modules, nil
}
