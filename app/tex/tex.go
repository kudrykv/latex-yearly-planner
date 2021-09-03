package tex

import (
	"errors"
	"fmt"
	"io"
	"text/template"

	"github.com/kudrykv/latex-yearly-planner/app/config"
)

var tpl = template.Must(template.New("").Funcs(template.FuncMap{
	"dict": func(values ...interface{}) (map[string]interface{}, error) {
		if len(values)%2 != 0 {
			return nil, errors.New("invalid dict call")
		}
		dict := make(map[string]interface{}, len(values)/2)
		for i := 0; i < len(values); i += 2 {
			key, ok := values[i].(string)
			if !ok {
				return nil, errors.New("dict keys must be strings")
			}

			dict[key] = values[i+1]
		}

		return dict, nil
	},
}).ParseGlob(`./tpls/*`))

type Tex struct {
	tpl *template.Template
}

func New() Tex {
	return Tex{
		tpl: tpl,
	}
}

func (t Tex) Document(wr io.Writer, cfg config.Config, files []string) error {
	type pack struct {
		Cfg   config.Config
		Files []string
	}

	data := pack{Cfg: cfg, Files: files}
	if err := t.tpl.ExecuteTemplate(wr, "document.tpl", data); err != nil {
		return fmt.Errorf("execute template: %w", err)
	}

	return nil
}

func (t Tex) Execute(wr io.Writer, name string, data interface{}) error {
	if err := t.tpl.ExecuteTemplate(wr, name, data); err != nil {
		return fmt.Errorf("execute template: %w", err)
	}

	return nil
}
