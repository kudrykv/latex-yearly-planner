CURRENT_YEAR=$(date +"%Y")
NEXT_YEAR=$((CURRENT_YEAR+1))

_sn_a5x="cfg/base.yaml,cfg/sn_a5x.base.yaml"
_rm2="cfg/base.yaml,cfg/rm2_ddvk.base.yaml"

configurations=(
  "${_sn_a5x},cfg/template_planner_yearly.yaml,cfg/sn_a5x.planner.yaml"
  "${_rm2},cfg/template_planner_yearly.yaml,cfg/rm2_ddvk.planner.yaml"
  "${_sn_a5x},cfg/template_planner_daily_with_cal.yaml,cfg/sn_a5x.planner.daily-with-cal.yaml"
  "${_rm2},cfg/template_planner_daily_with_cal.yaml,cfg/rm2_ddvk.planner.daily-with-cal.yaml"
)

for year in $CURRENT_YEAR; do
  for cfg in "${configurations[@]}"; do
    PLANNER_YEAR=${year} CFG="${cfg}" ./single.sh
  done
done
