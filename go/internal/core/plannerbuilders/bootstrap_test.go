package plannerbuilders_test

import (
	"github.com/golang/mock/gomock"
	"github.com/kudrykv/latex-yearly-planner/internal/core/plannerbuilders"
	"github.com/kudrykv/latex-yearly-planner/internal/core/plannerbuilders/mocks"
	"testing"
)

type mocked struct {
	indexer *mocks.MockIndexer
	section *mocks.MockSection
}

func setup(t *testing.T) (*plannerbuilders.Builder, mocked) {
	t.Helper()

	controller := gomock.NewController(t)

	section := mocks.NewMockSection(controller)
	indexer := mocks.NewMockIndexer(controller)

	builder := plannerbuilders.New(indexer, plannerbuilders.Sections{section})

	return builder, mocked{
		indexer: indexer,
		section: section,
	}
}
