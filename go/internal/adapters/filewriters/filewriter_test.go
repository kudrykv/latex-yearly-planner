package filewriters_test

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/filewriters"
	"github.com/kudrykv/latex-yearly-planner/internal/core/entities"
	"github.com/stretchr/testify/require"
	"os"
	"testing"
)

func TestFileWriter_Write(t *testing.T) {
	t.Parallel()

	basePath := "."
	fileName := "test"
	note := entities.Note{Name: fileName, Contents: []byte(`hello world`)}

	t.Run("should write to file", func(t *testing.T) {
		t.Parallel()

		writer := filewriters.New(basePath)

		err := writer.Write(context.Background(), note)

		require.NoError(t, err)
		require.NoError(t, os.Remove(fileName))
	})
}
