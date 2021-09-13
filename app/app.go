package app

import (
	"bytes"
	"errors"
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

	pathConfigs := strings.Split(c.Path(fConfig), ",")
	if cfg, err = config.New(pathConfigs...); err != nil {
		return fmt.Errorf("config new: %w", err)
	}

	wr := &bytes.Buffer{}

	t := tex.New()

	if err = t.Document(wr, cfg); err != nil {
		return fmt.Errorf("tex document: %w", err)
	}

	if err = ioutil.WriteFile("out/"+RootFilename(pathConfigs[len(pathConfigs)-1]), wr.Bytes(), 0600); err != nil {
		return fmt.Errorf("ioutil write file: %w", err)
	}

	for _, file := range cfg.Pages {
		wr.Reset()

		var mom []page.Modules
		for _, block := range file.RenderBlocks {
			if fn, ok = ComposerMap[block.FuncName]; !ok {
				return fmt.Errorf("unknown func " + block.FuncName)
			}

			modules, err := fn(cfg, block.Tpls)
			if err != nil {
				return fmt.Errorf("%s: %w", block.FuncName, err)
			}

			mom = append(mom, modules)
		}

		if len(mom) == 0 {
			return fmt.Errorf("modules of modules must have some modules")
		}

		allLen := len(mom[0])
		for _, mods := range mom {
			if len(mods) != allLen {
				return errors.New("some modules are not aligned")
			}
		}

		for i := 0; i < allLen; i++ {
			for _, mod := range mom {
				if err = t.Execute(wr, mod[i].Tpl, mod[i]); err != nil {
					return fmt.Errorf("execute: %w", err)
				}
			}
		}

		if err = ioutil.WriteFile("out/"+file.Name+".tex", wr.Bytes(), 0600); err != nil {
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

type Composer func(cfg config.Config, tpls []string) (page.Modules, error)

var ComposerMap = map[string]Composer{
	"title":                compose.Title,
	"annual":               compose.Annual,
	"quarterly":            compose.Quarterly,
	"monthly":              compose.Monthly,
	"weekly":               compose.Weekly,
	"daily":                compose.Daily,
	"dailywmonth":          compose.DailyWMonth,
	"daily_reflect":        compose.DailyReflect,
	"daily_notes":          compose.DailyNotes,
	"notes_indexed":        compose.NotesIndexed,
	"todos_indexed":        compose.TodosIndexed,
	"header_annual":        compose.HeaderAnnual,
	"header_annual2":       compose.HeaderAnnual2,
	"header_quarterly":     compose.HeaderQuarterly,
	"header_quarterly2":    compose.HeaderQuarterly2,
	"header_monthly":       compose.HeaderMonthly,
	"header_monthly2":      compose.HeaderMonthly2,
	"header_weekly":        compose.HeaderWeekly,
	"header_daily":         compose.HeaderDaily,
	"header_daily_notes":   compose.HeaderDailyNotes,
	"header_daily_reflect": compose.HeaderDailyReflect,
	"header_notes_indexed": compose.HeaderNotesIndexed,
	"header_todos_indexed": compose.HeaderTodosIndexed,
}
