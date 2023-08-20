package main

import (
	"context"
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/cmd/app"
	"os"
)

func main() {
	if err := app.New(os.Stdin, os.Stdout, os.Stderr).Run(context.Background(), os.Args); err != nil {
		fmt.Println(err)
	}
}
