PLANNER_YEAR=${PLANNER_YEAR:-$(date +"%Y")}
export PLANNER_YEAR

for cfg in cfg/*yaml; do
  go run cmd/plannergen/plannergen.go --config "${cfg}"
  nakedname=$(echo "${cfg}" | cut -d'/' -f 2-99 | rev | cut -d'.' -f 2-99 | rev)
  pdflatex -file-line-error -interaction=nonstopmode -synctex=1 -output-format=pdf -output-directory=./out "out/${nakedname}.tex"
  cp "out/${nakedname}.pdf" "${nakedname}.pdf"
done
