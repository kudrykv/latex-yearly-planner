CURRENT_YEAR=$(date +"%Y")
NEXT_YEAR=$((CURRENT_YEAR+1))

for year in $CURRENT_YEAR $NEXT_YEAR; do
  for cfg in cfg/*yaml; do
    PLANNER_YEAR=${year} go run cmd/plannergen/plannergen.go --config "${cfg}"

    nakedname=$(echo "${cfg}" | cut -d'/' -f 2-99 | rev | cut -d'.' -f 2-99 | rev)

    pdflatex \
      -file-line-error \
      -interaction=nonstopmode \
      -synctex=1 \
      -output-format=pdf \
      -output-directory=./out \
      "out/${nakedname}.tex"

    cp "out/${nakedname}.pdf" "${year}.${nakedname}.pdf"
  done
done