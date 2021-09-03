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
	WithWeeks bool `env:"PLANNER_WITH_WEEKS"`

	Layout Layout
}

type Layout struct {
	Paper Paper

	Numbers Numbers
	Lengths Lengths
}

type Numbers struct {
	ArrayStretch float64
}

type Lengths struct {
	TabColSep            string
	LineThicknessDefault string
	LineThicknessThick   string
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