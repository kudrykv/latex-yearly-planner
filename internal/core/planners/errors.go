package planners

import "errors"

var (
	ErrNothingToWrite   = errors.New("nothing to write")
	ErrNothingToCompile = errors.New("nothing to compile")
)
