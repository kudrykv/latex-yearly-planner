package app

import (
	"context"
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/commanders"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/filewriters"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/mosdocument"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/mostitles"
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

								var documentParameters YAMLMOS
								if err := yaml.Unmarshal(fileBytes, &documentParameters); err != nil {
									return fmt.Errorf("unmarshal: %w", err)
								}

								document, err := mosdocument.New(documentParameters.ToDocumentParameters())
								if err != nil {
									return fmt.Errorf("new document: %w", err)
								}

								templateText, err := document.Execute()
								if err != nil {
									return fmt.Errorf("execute: %w", err)
								}

								fileWriter := filewriters.New("./out")
								cmder := commanders.New("./out")

								indexer, err := texindexer.New(templateText)
								if err != nil {
									return fmt.Errorf("new indexer: %w", err)
								}

								titleSection := mostitles.New(mostitles.TitleParameters{IsEnabled: true, Name: "hello world"})

								builder := plannerbuilders.New(indexer, plannerbuilders.Sections{titleSection})

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
