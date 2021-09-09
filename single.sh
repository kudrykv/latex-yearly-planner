#!/usr/bin/env bash

set -eo pipefail

go run cmd/plannergen/plannergen.go --config "${CFG}"

nakedname=$(echo "${CFG}" | cut -d'/' -f 2-99 | rev | cut -d'.' -f 2-99 | rev)

pdflatex \
  -file-line-error \
  -interaction=nonstopmode \
  -synctex=1 \
  -output-format=pdf \
  -output-directory=./out \
  "out/${nakedname}.tex"

cp "out/${nakedname}.pdf" "${PLANNER_YEAR}.${nakedname}.pdf"