package texindexer_test

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/texindexer"
	"github.com/kudrykv/latex-yearly-planner/internal/core/planners/entities"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestTeXIndexer_CreateIndex(t *testing.T) {
	t.Parallel()

	ctx := context.Background()
	files := entities.Notes{
		{Name: "first.tex", Contents: []byte("unused here")},
		{Name: "second.tex", Contents: []byte("unused there")},
	}

	templateString := `doc begins here — {{ .Notes }} — doc ends here`

	expected := entities.Note{
		Name: "index.tex",
		Contents: []byte(
			`doc begins here — \include{first.tex}` + "\n" + `\include{second.tex} — doc ends here`,
		),
	}

	t.Run("should create an index", func(t *testing.T) {
		t.Parallel()

		indexer, err := texindexer.New(templateString)

		require.NoError(t, err)

		index, err := indexer.CreateIndex(ctx, files)

		require.NoError(t, err)
		require.Equal(t, expected, index)
	})
}
