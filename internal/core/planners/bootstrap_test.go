package planners_test

import (
	"github.com/golang/mock/gomock"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners/mocks"
	"testing"
)

type mocked struct {
	builder    *mocks.MockBuilder
	fileWriter *mocks.MockFileWriter
	commander  *mocks.MockCommander
	command    *mocks.MockCommand
}

func setup(t *testing.T) (planners.Planner, mocked) {
	t.Helper()

	controller := gomock.NewController(t)

	builder := mocks.NewMockBuilder(controller)
	writer := mocks.NewMockFileWriter(controller)
	commander := mocks.NewMockCommander(controller)
	command := mocks.NewMockCommand(controller)

	planner := planners.New(builder, writer, commander)

	return planner, mocked{
		builder:    builder,
		fileWriter: writer,
		commander:  commander,
		command:    command,
	}
}
