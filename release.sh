CURRENT_YEAR=$(date +"%Y")
NEXT_YEAR=$((CURRENT_YEAR+1))

for year in $CURRENT_YEAR $NEXT_YEAR; do
  for cfg in cfg/*yaml; do
    PLANNER_YEAR=${year} CFG="${cfg}" ./single.sh
  done
done