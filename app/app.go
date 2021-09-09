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
		fn  Composer
		ok  bool
		cfg config.Config
		err error
	)

	pathConfig := c.Path(fConfig)
	if cfg, err = config.New(pathConfig); err != nil {
		return fmt.Errorf("config new: %w", err)
	}

	wr := &bytes.Buffer{}

	t := tex.New()

	if err = t.Document(wr, cfg); err != nil {
		return fmt.Errorf("tex document: %w", err)
	}

	if err = ioutil.WriteFile("out/"+RootFilename(pathConfig), wr.Bytes(), 0600); err != nil {
		return fmt.Errorf("ioutil write file: %w", err)
	}

	for _, file := range cfg.RenderBlocks {
		wr.Reset()

		if fn, ok = ComposerMap[file]; !ok {
			continue
		}

		for _, pag := range fn(cfg) {
			pag.Cfg = cfg

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

type Composer func(config.Config) []page.Page

var ComposerMap = map[string]Composer{
	"title":        compose.Title,
	"annual":       compose.Annual,
	"quarterly":    compose.Quarterly,
	"monthly":      compose.Monthly,
	"weekly":       compose.Weekly,
	"daily":        compose.Daily,
	"dailyreflect": compose.DailyReflect,
	"dailynotes":   compose.DailyNotes,
	"notesindexed": compose.NotesIndexed,
	"todosindexed": compose.TodosIndexed,
}
