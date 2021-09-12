package page

import (
	"github.com/kudrykv/latex-yearly-planner/app/config"
)

type PageTpl struct {
	Cfg config.Config

	Pages []Page
}

type Page struct {
	Cfg    config.Config
	Tpl    string
	Header interface{}
	Body   interface{}
}
