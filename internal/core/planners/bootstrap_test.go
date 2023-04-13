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
}

func setup(t *testing.T) (planners.Planner, mocked) {
	t.Helper()

	controller := gomock.NewController(t)

	builder := mocks.NewMockBuilder(controller)
	writer := mocks.NewMockFileWriter(controller)

	planner := planners.New(builder, writer)

	return planner, mocked{
		builder:    builder,
		fileWriter: writer,
	}
}
