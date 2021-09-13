package config

import (
	"fmt"
	"io/ioutil"
	"strings"
	"time"

	"github.com/caarlos0/env/v6"
	"gopkg.in/yaml.v3"
)

type Config struct {
	Debug Debug

	Year      int `env:"PLANNER_YEAR"`
	WeekStart time.Weekday

	Pages Pages

	Layout Layout
	Blocks Blocks
}

type Debug struct {
	ShowFrame bool
	ShowLinks bool
}

type Pages []Page
type Page struct {
	Name         string
	RenderBlocks RenderBlocks
}

type RenderBlocks []RenderBlock

func (r Pages) WeeklyEnabled() bool {
	for _, s := range r {
		for _, block := range s.RenderBlocks {
			if block.FuncName == "weekly" {
				return true
			}
		}
	}

	return false
}

type RenderBlock struct {
	FuncName string
	Tpls     []string
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

	ReverseMargins bool
	MarginParWidth string
	MarginParSep   string
}

type Margin struct {
	Top    string `env:"PLANNER_LAYOUT_PAPER_MARGIN_TOP"`
	Bottom string `env:"PLANNER_LAYOUT_PAPER_MARGIN_BOTTOM"`
	Left   string `env:"PLANNER_LAYOUT_PAPER_MARGIN_LEFT"`
	Right  string `env:"PLANNER_LAYOUT_PAPER_MARGIN_RIGHT"`
}

func New(pathConfigs ...string) (Config, error) {
	var (
		bts []byte
		err error
		cfg Config
	)

	for _, filepath := range pathConfigs {
		if bts, err = ioutil.ReadFile(strings.ToLower(filepath)); err != nil {
			return cfg, fmt.Errorf("ioutil read file: %w", err)
		}

		if err = yaml.Unmarshal(bts, &cfg); err != nil {
			return cfg, fmt.Errorf("yaml unmarshal: %w", err)
		}
	}

	if err = env.Parse(&cfg); err != nil {
		return cfg, fmt.Errorf("env parse: %w", err)
	}

	if cfg.Year == 0 {
		cfg.Year = time.Now().Year()
	}

	return cfg, nil
}
