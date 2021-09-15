CURRENT_YEAR=$(date +"%Y")
NEXT_YEAR=$((CURRENT_YEAR+1))

_sn_a5x="cfg/base.yaml,cfg/base.supernote_a5x.yaml"
_rm2="cfg/base.yaml,cfg/base.rm2.yaml"

configurations=(
#  "${_sn_a5x},cfg/template_planner_yearly.yaml,cfg/planner.supernote_a5x.yaml"
#  "${_rm2},cfg/template_planner_yearly.yaml,cfg/planner.rm2_ddvk.yaml"
#  "${_sn_a5x},cfg/template_planner_daily_with_cal.yaml,cfg/planner.supernote_a5x.daily-with-cal.yaml"
  "${_rm2},cfg/template_planner_daily_with_cal.yaml,cfg/planner.rm2_ddvk.daily-with-cal.yaml"
)

for year in $CURRENT_YEAR; do
  for cfg in "${configurations[@]}"; do
    PLANNER_YEAR=${year} CFG="${cfg}" ./single.sh
  done
done
