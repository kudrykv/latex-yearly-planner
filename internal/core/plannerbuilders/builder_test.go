package plannerbuilders_test

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners/entities"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestBuilder_Generate(t *testing.T) {
	t.Parallel()

	ctx := context.Background()
	file := entities.File{Name: "file.tex", Contents: []byte(`hello world`)}
	files := entities.Files{file}
	indexFile := entities.File{Name: "index.tex", Contents: []byte(`index`)}
	expected := entities.FileStructure{
		Index: indexFile,
		Files: files,
	}

	t.Run("successful run", func(t *testing.T) {
		t.Parallel()

		builder, m := setup(t)

		m.section.EXPECT().IsEnabled().Return(true)
		m.section.EXPECT().GenerateSection(ctx).Return(file, nil)
		m.indexer.EXPECT().CreateIndex(ctx, files).Return(indexFile, nil)

		fileStructure, err := builder.Generate(ctx)

		require.NoError(t, err)
		require.Equal(t, expected, fileStructure)
	})
}
