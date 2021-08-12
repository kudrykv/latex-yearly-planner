CURRENT_YEAR=$(date +"%Y")
NEXT_YEAR=$((CURRENT_YEAR+1))

for year in $CURRENT_YEAR $NEXT_YEAR; do
  ./build.sh --planner-year "${year}" --vendor rm2_ddvk --left-handed true
  ./build.sh --planner-year "${year}" --vendor rm2_ddvk

  ./build.sh --planner-year "${year}" --vendor supernote_a5x
done