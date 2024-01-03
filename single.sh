#!/usr/bin/env bash

set -eo pipefail

ICSFILE="${ICSFILE:-}"
# ICSFILE="app/components/icsparser/example_calendar.ics"

if [ -z "$PLANNERGEN_BINARY" ]; then
  export GO_CMD="go run cmd/plannergen/plannergen.go"
else
  export GO_CMD="$PLANNERGEN_BINARY"
  echo "Building using plannergen binary at \"${PLANNERGEN_BINARY}\""
fi

if [ -z "$PREVIEW" ]; then
  eval $GO_CMD --config "${CFG}" --icsfile "${ICSFILE}"
else
  eval $GO_CMD --preview --config "${CFG}" --icsfile "${ICSFILE}"
fi



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
    "out/${nakedname}.tex" > /dev/null
done

if [ -n "${NAME}" ]; then
  cp "out/${nakedname}.pdf" "${NAME}.pdf"
  echo "created ${NAME}.pdf"
else
  cp "out/${nakedname}.pdf" "${nakedname}.pdf"
  echo "created ${nakedname}.pdf"
fi
