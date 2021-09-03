package page

import (
	"github.com/kudrykv/latex-yearly-planner/app/components/header"
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

type PageTpl struct {
	Cfg config.Config

	Pages []Page
}

type Page struct {
	Header header.Header
	Body   interface{}
}
