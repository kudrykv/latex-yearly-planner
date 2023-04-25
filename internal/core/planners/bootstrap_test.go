package planners_test

import (
	"github.com/golang/mock/gomock"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners/mocks"
	"testing"
)

type mocked struct {
	builder    *mocks.MockPlannerBuilder
	noteWriter *mocks.MockNoteWriter
	commander  *mocks.MockCommander
}

func setup(t *testing.T) (*planners.Planner, mocked) {
	t.Helper()

	controller := gomock.NewController(t)

	builder := mocks.NewMockPlannerBuilder(controller)
	writer := mocks.NewMockNoteWriter(controller)
	commander := mocks.NewMockCommander(controller)

	planner := planners.New(builder, writer, commander)

	return planner, mocked{
		builder:    builder,
		noteWriter: writer,
		commander:  commander,
	}
}
