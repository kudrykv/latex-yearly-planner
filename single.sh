#!/usr/bin/env bash

set -eo pipefail

go run cmd/plannergen/plannergen.go --config "${CFG}"

nakedname=$(echo "${CFG}" | rev | cut -d, -f1 | cut -d'/' -f 1 | cut -d'.' -f 2-99 | rev)

_passes=(1)

if [[ -n "${PASSES}" ]]; then
  # shellcheck disable=SC2207
  _passes=($(seq 1 "${PASSES}"))
fi

for _ in "${_passes[@]}"; do
  pdflatex \
    -file-line-error \
    -interaction=nonstopmode \
    -synctex=1 \
    -output-format=pdf \
    -output-directory=./out \
    "out/${nakedname}.tex"
done

cp "out/${nakedname}.pdf" "${PLANNER_YEAR}.${nakedname}.pdf"
echo "created ${PLANNER_YEAR}.${nakedname}.pdf"