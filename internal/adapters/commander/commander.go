package commander

import (
	"context"
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners"
	"os/exec"
)

type Commander struct {
	basePath string
}

func New(basePath string) Commander {
	return Commander{
		basePath: basePath,
	}
}

func (r Commander) Run(_ context.Context, name planners.CommandName, arg ...planners.StringArg) error {
	command := exec.Command(name, arg...)
	command.Dir = r.basePath

	if err := command.Run(); err != nil {
		return fmt.Errorf("run command %s: %w", name, err)
	}

	return nil
}
