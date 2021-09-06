package compose

import (
	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

func Title(cfg config.Config) []page.Page {
	return []page.Page{{Tpl: cfg.Blocks.Title.Tpl}}
}
