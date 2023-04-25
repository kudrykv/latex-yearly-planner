package planners_test

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners/entities"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestPlanner_Generate(t *testing.T) {
	t.Parallel()

	ctx := context.Background()
	fileStructure := entities.NoteStructure{}

	t.Run("successful run", func(t *testing.T) {
		t.Parallel()

		planner, m := setup(t)

		m.builder.EXPECT().Generate(ctx).Return(fileStructure, nil)

		err := planner.Generate(ctx)

		require.NoError(t, err)
	})

	t.Run("error when generate returns an error", func(t *testing.T) {
		t.Parallel()

		planner, m := setup(t)

		m.builder.EXPECT().Generate(ctx).Return(entities.NoteStructure{}, assert.AnError)

		err := planner.Generate(ctx)

		require.ErrorIs(t, err, assert.AnError)
	})
}

func TestPlanner_Write(t *testing.T) {
	t.Parallel()

	ctx := context.Background()
	fileStructure := entities.NoteStructure{
		Index: entities.Note{Name: "index.tex"},
		Notes: []entities.Note{{Name: "file1.tex"}, {Name: "file2.tex"}},
	}

	t.Run("successful run", func(t *testing.T) {
		t.Parallel()

		planner, m := setup(t)

		m.builder.EXPECT().Generate(ctx).Return(fileStructure, nil)
		m.noteWriter.EXPECT().Write(ctx, fileStructure.Index).Return(nil)
		m.noteWriter.EXPECT().Write(ctx, fileStructure.Notes[0]).Return(nil)
		m.noteWriter.EXPECT().Write(ctx, fileStructure.Notes[1]).Return(nil)

		err := planner.Generate(ctx)

		require.NoError(t, err)

		err = planner.Write(ctx)

		require.NoError(t, err)
	})

	t.Run("error when generate returns an error", func(t *testing.T) {
		t.Parallel()

		planner, m := setup(t)

		m.builder.EXPECT().Generate(ctx).Return(entities.NoteStructure{}, assert.AnError)

		err := planner.Generate(ctx)

		require.ErrorIs(t, err, assert.AnError)

		err = planner.Write(ctx)

		require.ErrorIs(t, err, planners.ErrNothingToWrite)
	})

	t.Run("error when write returns an error", func(t *testing.T) {
		t.Parallel()

		planner, m := setup(t)

		m.builder.EXPECT().Generate(ctx).Return(fileStructure, nil)
		m.noteWriter.EXPECT().Write(ctx, fileStructure.Index).Return(assert.AnError)

		err := planner.Generate(ctx)

		require.NoError(t, err)

		err = planner.Write(ctx)

		require.ErrorIs(t, err, assert.AnError)
	})
}

func TestPlanner_Compile(t *testing.T) {
	t.Parallel()

	ctx := context.Background()
	fileStructure := entities.NoteStructure{
		Index: entities.Note{Name: "index.tex"},
		Notes: []entities.Note{{Name: "file1.tex"}, {Name: "file2.tex"}},
	}

	t.Run("successful run", func(t *testing.T) {
		t.Parallel()

		planner, m := setup(t)

		m.builder.EXPECT().Generate(ctx).Return(fileStructure, nil)
		m.noteWriter.EXPECT().Write(ctx, fileStructure.Index).Return(nil)
		m.noteWriter.EXPECT().Write(ctx, fileStructure.Notes[0]).Return(nil)
		m.noteWriter.EXPECT().Write(ctx, fileStructure.Notes[1]).Return(nil)
		m.commander.EXPECT().Run(ctx, "pdflatex", fileStructure.Index.Name).Return(nil)

		err := planner.Generate(ctx)

		require.NoError(t, err)

		err = planner.Write(ctx)

		require.NoError(t, err)

		err = planner.Compile(ctx)

		require.NoError(t, err)
	})

	t.Run("error when generate returns an error", func(t *testing.T) {
		t.Parallel()

		planner, m := setup(t)

		m.builder.EXPECT().Generate(ctx).Return(entities.NoteStructure{}, assert.AnError)

		err := planner.Generate(ctx)

		require.ErrorIs(t, err, assert.AnError)

		err = planner.Compile(ctx)

		require.ErrorIs(t, err, planners.ErrNothingToCompile)
	})

	t.Run("error when generate has not been run", func(t *testing.T) {
		t.Parallel()

		planner, _ := setup(t)

		err := planner.Compile(ctx)

		require.ErrorIs(t, err, planners.ErrNothingToCompile)
	})

	t.Run("error when compile returns an error", func(t *testing.T) {
		t.Parallel()

		planner, m := setup(t)

		m.builder.EXPECT().Generate(ctx).Return(fileStructure, nil)
		m.commander.EXPECT().Run(ctx, "pdflatex", fileStructure.Index.Name).Return(assert.AnError)

		err := planner.Generate(ctx)

		require.NoError(t, err)

		err = planner.Compile(ctx)

		require.ErrorIs(t, err, assert.AnError)
	})
}
