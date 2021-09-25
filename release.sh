CURRENT_YEAR=$(date +"%Y")
NEXT_YEAR=$((CURRENT_YEAR+1))

_sn_a5x="cfg/base.yaml,cfg/sn_a5x.base.yaml"
_sn_a5x_lh="cfg/base.yaml,cfg/sn_a5x_lh.base.yaml"
_rm2="cfg/base.yaml,cfg/rm2.base.yaml"
_rm2_ddvk="cfg/base.yaml,cfg/rm2_ddvk.base.yaml"
_rm2_ddvk_lh="cfg/base.yaml,cfg/rm2_ddvk_lh.base.yaml"

_configurations=(
  1 "${_rm2},cfg/template_planner_yearly.yaml,cfg/rm2.planner.yaml"
  2 "${_rm2},cfg/template_planner_daily_with_cal.yaml,cfg/rm2.planner.daily-with-cal.yaml"
  1 "${_rm2_ddvk},cfg/template_planner_yearly.yaml,cfg/rm2_ddvk.planner.yaml"
  2 "${_rm2_ddvk},cfg/template_planner_daily_with_cal.yaml,cfg/rm2_ddvk.planner.daily-with-cal.yaml"
  1 "${_rm2_ddvk_lh},cfg/template_planner_yearly.yaml,cfg/rm2_ddvk_lh.planner.yaml"
  2 "${_rm2_ddvk_lh},cfg/template_planner_daily_with_cal.yaml,cfg/rm2_ddvk_lh.planner.daily-with-cal.yaml"
  1 "${_sn_a5x},cfg/template_planner_yearly.yaml,cfg/sn_a5x.planner.yaml"
  2 "${_sn_a5x},cfg/template_planner_daily_with_cal.yaml,cfg/sn_a5x.planner.daily-with-cal.yaml"
  2 "${_sn_a5x_lh},cfg/template_planner_daily_with_cal.yaml,cfg/sn_a5x_lh.planner.daily-with-cal.yaml"
)

_configurations_len=${#_configurations[@]}

for _year in $CURRENT_YEAR $NEXT_YEAR; do
  for _idx in $(seq 0 2 $((_configurations_len-1))); do
    _passes=${_configurations[_idx]}
    _cfg=${_configurations[_idx+1]}

    PLANNER_YEAR=${_year} PASSES=${_passes} CFG="${_cfg}" ./single.sh
  done
done
