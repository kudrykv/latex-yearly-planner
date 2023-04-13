package app

import (
	"context"
	"fmt"
	"github.com/urfave/cli/v2"
	"io"
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
							Action: func(cliContext *cli.Context) error {
								panic("not implemented")
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
