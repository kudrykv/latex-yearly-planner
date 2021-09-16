CURRENT_YEAR=$(date +"%Y")
NEXT_YEAR=$((CURRENT_YEAR+1))

_sn_a5x="cfg/base.yaml,cfg/sn_a5x.base.yaml"
_sn_a5x_lh="cfg/base.yaml,cfg/sn_a5x_lh.base.yaml"
_rm2="cfg/base.yaml,cfg/rm2_ddvk.base.yaml"
_rm2_lh="cfg/base.yaml,cfg/rm2_ddvk_lh.base.yaml"

configurations=(
  "${_rm2},cfg/template_planner_yearly.yaml,cfg/rm2_ddvk.planner.yaml"
  "${_rm2},cfg/template_planner_daily_with_cal.yaml,cfg/rm2_ddvk.planner.daily-with-cal.yaml"
  "${_rm2_lh},cfg/template_planner_yearly.yaml,cfg/rm2_ddvk_lh.planner.yaml"
  "${_rm2_lh},cfg/template_planner_daily_with_cal.yaml,cfg/rm2_ddvk_lh.planner.daily-with-cal.yaml"
  "${_sn_a5x},cfg/template_planner_yearly.yaml,cfg/sn_a5x.planner.yaml"
  "${_sn_a5x},cfg/template_planner_daily_with_cal.yaml,cfg/sn_a5x.planner.daily-with-cal.yaml"
  "${_sn_a5x_lh},cfg/template_planner_daily_with_cal.yaml,cfg/sn_a5x_lh.planner.daily-with-cal.yaml"
)

for year in $CURRENT_YEAR $NEXT_YEAR; do
  for cfg in "${configurations[@]}"; do
    PLANNER_YEAR=${year} CFG="${cfg}" ./single.sh
  done
done
