#!/usr/bin/env bash

set -eo pipefail

go run cmd/plannergen/plannergen.go --config "${CFG}"

nakedname=$(echo "${CFG}" | rev | cut -d, -f1 | cut -d'/' -f 1 | cut -d'.' -f 2-99 | rev)

# Even with pdflatex, it requires even more passes.
# Two should be enough
for _ in 1 2; do
  pdflatex \
    -file-line-error \
    -interaction=nonstopmode \
    -synctex=1 \
    -output-format=pdf \
    -output-directory=./out \
    "out/${nakedname}.tex"
done

cp "out/${nakedname}.pdf" "${PLANNER_YEAR}.${nakedname}.pdf"