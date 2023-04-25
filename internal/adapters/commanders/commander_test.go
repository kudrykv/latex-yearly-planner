package commanders_test

import (
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/commanders"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestCommander_Run(t *testing.T) {
	t.Parallel()

	t.Run("should run a command", func(t *testing.T) {
		cmder := commanders.New(".")

		err := cmder.Run(context.Background(), "echo", "hello")

		require.NoError(t, err)
	})

	t.Run("should return an error if command failed", func(t *testing.T) {
		cmder := commanders.New(".")

		err := cmder.Run(context.Background(), "false")

		require.ErrorContains(t, err, "run command false:")
	})
}
