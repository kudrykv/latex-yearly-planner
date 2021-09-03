package app

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"os"
	"strings"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/calendar"
	"github.com/kudrykv/latex-yearly-planner/app/components/header"
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

type PageTpl struct {
	Cfg    config.Config
	Header header.Header

	Body interface{}
}

func action(c *cli.Context) error {
	var (
		data PageTpl
		cfg  config.Config
		err  error
	)

	pathConfig := c.Path(fConfig)
	if cfg, err = config.New(pathConfig); err != nil {
		return fmt.Errorf("config new: %w", err)
	}

	wr := &bytes.Buffer{}

	t := tex.New()
	files := []string{"title", "year"}
	data.Cfg = cfg

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
		)

		switch file {
		case "title":
			tplName = "title.tpl"

		case "year":
			tplName, data.Body, data.Header = ComposeYear(cfg)
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

func ComposeYear(cfg config.Config) (string, interface{}, header.Header) {
	var quarters [][]calendar.Calendar

	for quarter := time.January; quarter <= time.December; quarter += 3 {
		weeks := make([]calendar.Calendar, 0, 3)

		for month := quarter; month < quarter+3; month++ {
			weeks = append(weeks, calendar.NewYearMonth(cfg.Year, month).Calendar(cfg.WeekStart))
		}

		quarters = append(quarters, weeks)
	}

	return "year.tpl", quarters, header.Header{
		Left: header.Items{
			header.NewTextItem("2021"),
			header.NewItemsGroup(
				header.NewTextItem("Q1"),
				header.NewTextItem("Q2"),
				header.NewTextItem("Q3"),
				header.NewTextItem("Q4"),
			),
		},
		Right: header.Items{header.NewTextItem("Notes"), header.NewTextItem("Todos")},
	}
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
