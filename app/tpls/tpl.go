package tpls

import (
	"errors"
	"fmt"
	"io"
	"strings"
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

	"incr": func(i int) int {
		return i + 1
	},

	"dec": func(i int) int {
		return i - 1
	},

	"is": func(i interface{}) bool {
		if value, ok := i.(bool); ok {
			return value
		}

		return i != nil
	},

	"escapeLatex": func(s string) string {
		replacements := map[string]string{
			"&": "\\&",
			"%": "\\%",
			"$": "\\$",
			"#": "\\#",
			"_": "\\_",
			"{": "\\{",
			"}": "\\}",
			"~": "\\textasciitilde",
			"^": "\\textasciicircum",
		}

		s = strings.ReplaceAll(s, "\\", "\\\\")
		for old, new := range replacements {
			s = strings.ReplaceAll(s, old, new)
		}
		return s
	},
}).ParseGlob(`./tpls/*`))

type Tpl struct {
	tpl *template.Template
}

func New() Tpl {
	return Tpl{
		tpl: tpl,
	}
}

func (t Tpl) Document(wr io.Writer, cfg config.Config) error {
	type pack struct {
		Cfg   config.Config
		Pages []config.Page
	}

	data := pack{Cfg: cfg, Pages: cfg.Pages}
	if err := t.tpl.ExecuteTemplate(wr, "document.tpl", data); err != nil {
		return fmt.Errorf("execute template: %w", err)
	}

	return nil
}

func (t Tpl) Execute(wr io.Writer, name string, data interface{}) error {
	if err := t.tpl.ExecuteTemplate(wr, name, data); err != nil {
		return fmt.Errorf("execute template: %w", err)
	}

	return nil
}
