package main

import (
	"context"
	"errors"
	"fmt"
	"os"
	"strings"

	"github.com/kudrykv/latex-yearly-planner/app"
)

var code int

func main() {
	ctx := context.Background()
	defer func() { os.Exit(code) }()

	shouldExit("", app.New().RunContext(ctx, os.Args))
}

func shouldExit(msg string, err error) bool {
	if err == nil {
		return false
	}

	code = 1

	printErr(msg, err)

	return true
}

// nolint:forbidigo
func printErr(msg string, err error) {

	if len(msg) > 0 {
		err = fmt.Errorf("%s: %w", msg, err)
	}

	indent := 0
	a, b := errors.Unwrap(err), err

	for a != nil {
		index := strings.Index(b.Error(), a.Error())

		fmt.Print(strings.Repeat(" ", indent))
		fmt.Println(b.Error()[0:index])
		indent += 2
		a, b = errors.Unwrap(a), a
	}

	fmt.Print(strings.Repeat(" ", indent))
	fmt.Println(b.Error())
}
