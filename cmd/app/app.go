package app

import (
	"context"
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/commanders"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/filewriters"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/components/mosannualbody"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/components/mosannualheader"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/components/mosdailybody"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/components/mosdailyheader"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/components/mosdailynotesbody"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/components/mosdailynotesheader"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/components/mosdailyreflectionsbody"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/components/mosdailyreflectionsheader"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/components/mosmonthlybody"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/components/mosmonthlyheader"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/components/mosquarterlybody"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/components/mosquarterlyheader"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/components/mosweeklybody"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/components/mosweeklyheader"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/mosdocument"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosannual"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosdaily"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosdailynotes"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosdailyreflections"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosmonthly"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosquarterly"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mostitles"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosweekly"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/refinfo"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/tex/noting"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/texindexer"
	"github.com/kudrykv/latex-yearly-planner/internal/core/plannerbuilders"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners"
	"github.com/urfave/cli/v2"
	"gopkg.in/yaml.v3"
	"io"
	"os"
)

type App struct {
	app cli.App
}

func New(reader io.Reader, writer, errWriter io.Writer) App {
	return App{
		app: cli.App{
			Reader:    reader,
			Writer:    writer,
			ErrWriter: errWriter,

			Commands: cli.Commands{
				{
					Name: "generate",
					Subcommands: cli.Commands{
						{
							Name: "mos",
							Flags: cli.FlagsByName{
								&cli.PathFlag{Name: "template-configuration"},
							},
							Action: func(cliContext *cli.Context) error {
								path := cliContext.Path("template-configuration")

								fileBytes, err := os.ReadFile(path)
								if err != nil {
									return fmt.Errorf("read file: %w", err)
								}

								var mosParameters YAMLMOS
								if err := yaml.Unmarshal(fileBytes, &mosParameters); err != nil {
									return fmt.Errorf("unmarshal: %w", err)
								}

								document, err := mosdocument.New(mosParameters.ToDocumentParameters())
								if err != nil {
									return fmt.Errorf("new document: %w", err)
								}

								templateText, err := document.Execute()
								if err != nil {
									return fmt.Errorf("execute: %w", err)
								}

								fileWriter := filewriters.New("./out")
								cmder := commanders.New("./out")

								pattern := noting.NewPattern(mosParameters.Parameters.Notes.Pattern)
								notes := noting.New(pattern)

								indexer, err := texindexer.New(templateText)
								if err != nil {
									return fmt.Errorf("new indexer: %w", err)
								}

								sectionTitle := mostitles.New(mostitles.TitleParameters{IsEnabled: true, Name: "hello world"})

								annualHeader, err := mosannualheader.New(mosParameters.ToParameters())
								if err != nil {
									return fmt.Errorf("new header: %w", err)
								}

								annualBody := mosannualbody.New(mosParameters.ToParameters(), mosParameters.LittleCalendarParameters())
								if err != nil {
									return fmt.Errorf("new body: %w", err)
								}

								sectionAnnual := mosannual.New(mosParameters.ToParameters(), mosParameters.AnnualParameters(), annualHeader, annualBody)

								quarterlyHeader := mosquarterlyheader.New()
								quarterlyBody := mosquarterlybody.New(mosParameters.LittleCalendarParameters(), notes)

								sectionQuarterly := mosquarterly.New(mosParameters.ToParameters(), mosParameters.QuarterlyParameters(), quarterlyHeader, quarterlyBody)

								monthlyHeader := mosmonthlyheader.New()
								monthlyBody := mosmonthlybody.New(mosParameters.LargeCalendarParameters(), notes)

								sectionMonthly := mosmonthly.New(mosParameters.ToParameters(), mosParameters.MonthlyParameters(), monthlyHeader, monthlyBody)

								weeklyHeader := mosweeklyheader.New()
								weeklyBody := mosweeklybody.New(notes)
								sectionWeekly := mosweekly.New(mosParameters.ToParameters(), mosParameters.WeeklyParameters(), weeklyHeader, weeklyBody)

								dailyHeader := mosdailyheader.New()
								dailyBody := mosdailybody.New(notes)
								sectionDaily := mosdaily.New(mosParameters.ToParameters(), mosParameters.DailyParameters(), dailyHeader, dailyBody)

								dailyReflectionsHeader := mosdailyreflectionsheader.New()
								dailyReflectionsBody := mosdailyreflectionsbody.New(notes)
								sectionDailyReflections := mosdailyreflections.New(mosParameters.ToParameters(), mosParameters.DailyReflectionsParameters(), dailyReflectionsHeader, dailyReflectionsBody)

								dailyNotesHeader := mosdailynotesheader.New()
								dailyNotesBody := mosdailynotesbody.New(notes)
								sectionDailyNotes := mosdailynotes.New(mosParameters.ToParameters(), mosParameters.DailyNotesParameters(), dailyNotesHeader, dailyNotesBody)

								refInfo := refinfo.New()

								sections := plannerbuilders.Sections{
									sectionTitle,
									sectionAnnual, sectionQuarterly, sectionMonthly, sectionWeekly,
									sectionDaily, sectionDailyReflections, sectionDailyNotes,
									refInfo,
								}
								builder := plannerbuilders.New(indexer, sections)

								planner := planners.New(builder, fileWriter, cmder)

								if err = planner.Generate(cliContext.Context); err != nil {
									return fmt.Errorf("generate: %w", err)
								}

								if err = planner.Write(cliContext.Context); err != nil {
									return fmt.Errorf("write: %w", err)
								}

								if err = planner.Compile(cliContext.Context); err != nil {
									return fmt.Errorf("compile: %w", err)
								}

								return nil
							},
						},
					},
				},
			},
		},
	}
}

func (r App) Run(ctx context.Context, arguments []string) error {
	if err := r.app.RunContext(ctx, arguments); err != nil {
		return fmt.Errorf("run context: %w", err)
	}

	return nil
}
