package planners_test

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners/entities"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners/mocks"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestPlanner_Generate(t *testing.T) {
	t.Parallel()

	builder := mocks.NewBuilder(t)
	writer := mocks.NewFileWriter(t)

	planner := planners.New(builder, writer)

	ctx := context.Background()
	fileStructure := entities.FileStructure{}

	t.Run("successful run", func(t *testing.T) {
		t.Parallel()

		builder.On("Generate", ctx).Return(fileStructure, nil).Once()

		err := planner.Generate(ctx)

		require.NoError(t, err)
	})

	t.Run("error when generate returns an error", func(t *testing.T) {
		t.Parallel()

		builder.On("Generate", ctx).Return(entities.FileStructure{}, assert.AnError).Once()

		err := planner.Generate(ctx)

		require.ErrorIs(t, err, assert.AnError)
	})
}
