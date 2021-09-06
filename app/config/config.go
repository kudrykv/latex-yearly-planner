package config

import (
	"fmt"
	"io/ioutil"
	"time"

	"github.com/caarlos0/env/v6"
	"gopkg.in/yaml.v3"
)

type Config struct {
	Year      int `env:"PLANNER_YEAR"`
	WeekStart time.Weekday

	RenderBlocks RenderBlocks

	Layout Layout
	Blocks Blocks
}

type RenderBlocks []string

func (r RenderBlocks) WeeklyEnabled() bool {
	for _, s := range r {
		if s == "weekly" {
			return true
		}
	}

	return false
}

type Blocks struct {
	Title        Title
	Annual       Annual
	Quarterly    Quarterly
	Monthly      Monthly
	Weekly       Weekly
	Daily        Daily
	DailyReflect DailyReflect
	DailyNotes   DailyNotes
	NotesIndexed NotesIndexed
	TodosIndexed TodosIndexed
}

type Title struct {
	Tpl string
}

type Annual struct {
	Tpl string
}

type Quarterly struct {
	Tpl string
}

type Monthly struct {
	Tpl string
}

type Weekly struct {
	Tpl string
}

type Daily struct {
	Tpl string
}

type DailyReflect struct {
	Tpl string
}

type DailyNotes struct {
	Tpl string
}

type NotesIndexed struct {
	TplIndex string
	TplPage  string
}

type TodosIndexed struct {
	TplIndex string
	TplPage  string
}

type Colors struct {
	Gray      string
	LightGray string
}

type Layout struct {
	Paper Paper

	Numbers Numbers
	Lengths Lengths
	Colors  Colors
}

type Numbers struct {
	ArrayStretch        float64
	QuarterlyLines      int
	WeeklyLines         int
	DailyTodos          int
	DailyNotes          int
	DailyBottomHour     int
	DailyTopHour        int
	DailyDiaryGoals     int
	DailyDiaryGrateful  int
	DailyDiaryBest      int
	DailyDiaryLog       int
	TodoLinesInTodoPage int
}

type Lengths struct {
	TabColSep            string
	LineThicknessDefault string
	LineThicknessThick   string
	LineHeightButLine    string
	TwoColSep            string
	TriColSep            string
	MonthlyCellHeight    string
	NotesIndexCellHeight string
}

type Paper struct {
	Width  string `env:"PLANNER_LAYOUT_PAPER_WIDTH"`
	Height string `env:"PLANNER_LAYOUT_PAPER_HEIGHT"`

	Margin Margin
}

type Margin struct {
	Top    string `env:"PLANNER_LAYOUT_PAPER_MARGIN_TOP"`
	Bottom string `env:"PLANNER_LAYOUT_PAPER_MARGIN_BOTTOM"`
	Left   string `env:"PLANNER_LAYOUT_PAPER_MARGIN_LEFT"`
	Right  string `env:"PLANNER_LAYOUT_PAPER_MARGIN_RIGHT"`
}

func New(filepath string) (Config, error) {
	var (
		bts []byte
		err error
		cfg Config
	)

	if bts, err = ioutil.ReadFile(filepath); err != nil {
		return cfg, fmt.Errorf("ioutil read file: %w", err)
	}

	if err = yaml.Unmarshal(bts, &cfg); err != nil {
		return cfg, fmt.Errorf("yaml unmarshal: %w", err)
	}

	if err = env.Parse(&cfg); err != nil {
		return cfg, fmt.Errorf("env parse: %w", err)
	}

	if cfg.Year == 0 {
		cfg.Year = time.Now().Year()
	}

	return cfg, nil
}
