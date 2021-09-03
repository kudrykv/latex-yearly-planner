package app

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"os"
	"strings"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/calendar"
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
		cfg config.Config
		err error
	)

	pathConfig := c.Path(fConfig)
	if cfg, err = config.New(pathConfig); err != nil {
		return fmt.Errorf("config new: %w", err)
	}

	wr := &bytes.Buffer{}

	files := []string{"title", "year"}

	t := tex.New()

	if err = t.Document(wr, cfg, files); err != nil {
		return fmt.Errorf("tex document: %w", err)
	}

	if err = ioutil.WriteFile("out/"+RootFilename(pathConfig), wr.Bytes(), 0600); err != nil {
		return fmt.Errorf("ioutil write file: %w", err)
	}

	for _, file := range files {
		wr.Reset()

		var (
			tplName string
			data    interface{}
		)

		switch file {
		case "title":
			tplName = "title.tpl"
			data = cfg

		case "year":
			type dat struct {
				Cfg  config.Config
				Qrtr [][]calendar.Calendar
			}

			tplName = "year.tpl"
			pack := dat{Cfg: cfg}

			for quarter := time.January; quarter <= time.December; quarter += 3 {
				weeks := make([]calendar.Calendar, 0, 3)

				for month := quarter; month < quarter+3; month++ {
					weeks = append(weeks, calendar.NewYearMonth(cfg.Year, month).Calendar(cfg.WeekStart))
				}

				pack.Qrtr = append(pack.Qrtr, weeks)
			}

			data = pack
		}

		if err = t.Execute(wr, tplName, data); err != nil {
			return fmt.Errorf("tex execute: %w", err)
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
