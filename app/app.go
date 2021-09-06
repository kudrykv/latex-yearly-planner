package app

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"os"
	"strings"

	"github.com/kudrykv/latex-yearly-planner/app/components/page"
	"github.com/kudrykv/latex-yearly-planner/app/compose"
	"github.com/kudrykv/latex-yearly-planner/app/config"
	"github.com/kudrykv/latex-yearly-planner/app/tex"
	"github.com/urfave/cli/v2"
)

const (
	fConfig = "config"
)

func New() *cli.App {
	return &cli.App{
		Name: "plannergen",

		Writer:    os.Stdout,
		ErrWriter: os.Stderr,

		Flags: []cli.Flag{
			&cli.PathFlag{Name: fConfig, Required: true},
		},

		Action: action,
	}
}

func action(c *cli.Context) error {
	var (
		data page.PageTpl
		cfg  config.Config
		err  error
	)

	pathConfig := c.Path(fConfig)
	if cfg, err = config.New(pathConfig); err != nil {
		return fmt.Errorf("config new: %w", err)
	}

	wr := &bytes.Buffer{}

	t := tex.New()
	// files := []string{"title", "year", "quarter", "month", "weekly", "daily", "daily_reflect", "daily_notes"}
	files := []string{"todos_indexed"}
	data.Cfg = cfg

	if err = t.Document(wr, cfg, files); err != nil {
		return fmt.Errorf("tex document: %w", err)
	}

	if err = ioutil.WriteFile("out/"+RootFilename(pathConfig), wr.Bytes(), 0600); err != nil {
		return fmt.Errorf("ioutil write file: %w", err)
	}

	for _, file := range files {
		wr.Reset()

		switch file {
		case "title":
			data.Pages = []page.Page{{Tpl: "title.tpl"}}

		case "year":
			data.Pages = compose.Annual(cfg)

		case "quarter":
			data.Pages = compose.Quarterly(cfg)

		case "month":
			data.Pages = compose.Monthly(cfg)

		case "weekly":
			data.Pages = compose.Weekly(cfg)

		case "daily":
			data.Pages = compose.Daily(cfg)

		case "daily_reflect":
			data.Pages = compose.DailyReflect(cfg)

		case "daily_notes":
			data.Pages = compose.DailyNotes(cfg)

		case "notes_indexed":
			data.Pages = compose.NotesIndexed(cfg)

		case "todos_indexed":
			data.Pages = compose.TodosIndexed(cfg)

		default:
			continue
		}

		for _, pag := range data.Pages {
			pag.Cfg = data.Cfg

			if err = t.Execute(wr, pag.Tpl, pag); err != nil {
				return fmt.Errorf("tex execute: %w", err)
			}
		}

		if err = ioutil.WriteFile("out/"+file+".tex", wr.Bytes(), 0600); err != nil {
			return fmt.Errorf("ioutil write file: %w", err)
		}
	}

	return nil
}

func RootFilename(pathconfig string) string {
	if idx := strings.LastIndex(pathconfig, "/"); idx >= 0 {
		pathconfig = pathconfig[idx+1:]
	}

	if strings.HasSuffix(pathconfig, ".yml") {
		pathconfig = pathconfig[:len(pathconfig)-len(".yml")]
	}

	if strings.HasSuffix(pathconfig, ".yaml") {
		pathconfig = pathconfig[:len(pathconfig)-len(".yaml")]
	}

	return pathconfig + ".tex"
}
