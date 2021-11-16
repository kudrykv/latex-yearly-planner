set -eo pipefail

CURRENT_YEAR=$(date +"%Y")
NEXT_YEAR=$((CURRENT_YEAR+1))

_configurations=(
  1 "cfg/base.yaml,cfg/template_breadcrumb.yaml,cfg/sn_a5x.breadcrumb.default.yaml"                                             "sn_a5x.breadcrumb.default"
#  1 "cfg/base.yaml,cfg/template_breadcrumb.yaml,cfg/sn_a5x.breadcrumb.default.yaml,cfg/sn_a5x.breadcrumb.default.dailycal.yaml" "sn_a5x.breadcrumb.default.dailycal"
#  2 "cfg/base.yaml,cfg/template_months_on_side.yaml,cfg/sn_a5x.mos.default.yaml"                                                "sn_a5x.mos.default"
#  2 "cfg/base.yaml,cfg/template_months_on_side.yaml,cfg/sn_a5x.mos.default.yaml,cfg/sn_a5x.mos.default.dailycal.yaml"           "sn_a5x.mos.default.dailycal"
#
#  1 "cfg/base.yaml,cfg/rm2.base.yaml,cfg/template_breadcrumb.yaml,cfg/rm2.breadcrumb.default.yaml"                                          "rm2.breadcrumb.default"
#  1 "cfg/base.yaml,cfg/rm2.base.yaml,cfg/template_breadcrumb.yaml,cfg/rm2.breadcrumb.default.yaml,cfg/rm2.breadcrumb.default.dailycal.yaml" "rm2.breadcrumb.default.dailycal"
#  2 "cfg/base.yaml,cfg/rm2.base.yaml,cfg/template_months_on_side.yaml,cfg/rm2.mos.default.yaml"                                             "rm2.mos.default"
#  2 "cfg/base.yaml,cfg/rm2.base.yaml,cfg/template_months_on_side.yaml,cfg/rm2.mos.default.yaml,cfg/rm2.mos.default.dailycal.yaml"           "rm2.mos.default.dailycal"
#
#  1 "cfg/base.yaml,cfg/rm2.base.yaml,cfg/rm2_ddvk.base.yaml,cfg/template_breadcrumb.yaml,cfg/rm2.breadcrumb.default.yaml"          "rm2_ddvk.breadcrumb.default"
#  1 "cfg/base.yaml,cfg/rm2.base.yaml,cfg/rm2_ddvk.base.yaml,cfg/template_breadcrumb.yaml,cfg/rm2.breadcrumb.default.dailycal.yaml" "rm2_ddvk.breadcrumb.default.dailycal"
#  2 "cfg/base.yaml,cfg/rm2.base.yaml,cfg/rm2_ddvk.base.yaml,cfg/template_months_on_side.yaml,cfg/rm2.mos.default.yaml"             "rm2_ddvk.mos.default"
#  2 "cfg/base.yaml,cfg/rm2.base.yaml,cfg/rm2_ddvk.base.yaml,cfg/template_months_on_side.yaml,cfg/rm2.mos.default.dailycal.yaml"    "rm2_ddvk.mos.default.dailycal"
#
#  1 "cfg/base.yaml,cfg/rm2.base.yaml,cfg/rm2_ddvk_lh.base.yaml,cfg/template_breadcrumb.yaml,cfg/rm2.breadcrumb.default.yaml"          "rm2_ddvk_lh.breadcrumb.default"
#  1 "cfg/base.yaml,cfg/rm2.base.yaml,cfg/rm2_ddvk_lh.base.yaml,cfg/template_breadcrumb.yaml,cfg/rm2.breadcrumb.default.dailycal.yaml" "rm2_ddvk_lh.breadcrumb.default.dailycal"
#  2 "cfg/base.yaml,cfg/rm2.base.yaml,cfg/rm2_ddvk_lh.base.yaml,cfg/template_months_on_side.yaml,cfg/rm2.mos.default.yaml"             "rm2_ddvk_lh.mos.default"
#  2 "cfg/base.yaml,cfg/rm2.base.yaml,cfg/rm2_ddvk_lh.base.yaml,cfg/template_months_on_side.yaml,cfg/rm2.mos.default.dailycal.yaml"    "rm2_ddvk_lh.mos.default.dailycal"
)

_configurations_len=${#_configurations[@]}

function createPDFs() {
  for _year in $CURRENT_YEAR; do
    for _idx in $(seq 0 3 $((_configurations_len-1))); do
      _passes=${_configurations[_idx]}
      _cfg=${_configurations[_idx+1]}
      _name=${_configurations[_idx+2]}

      PLANNER_YEAR="${_year}" PASSES="${_passes}" CFG="${_cfg}" NAME="${_name}.${_year}" ./single.sh
    done
  done
}

function mvDefaultTo() {
  for filename in ./*pdf; do
    _newname=$(echo "$filename" | perl -pe "s/default/$1/g")
    mv "$filename" "$_newname"
  done
}

function _mkLine() {
  sed -i 's/dotted: true/dotted: false/' cfg/base.yaml
}

function _mkSun() {
  sed -i 's/weekstart: 1/weekstart: 0/' cfg/base.yaml
}

function _mkAMPM() {
  sed -i 's/ampmtime: false/ampmtime: true/' cfg/base.yaml
}

function _restore() {
  git restore cfg/base.yaml
}

_combinations=(
  ""                        "dotted.default"
  "_mkLine"                 "lined.default"
  "_mkSun"                  "dotted.default.sun"
  "_mkLine _mkSun"          "lined.default.sun"
  "_mkAMPM"                 "dotted.default.ampm"
  "_mkAMPM _mkLine"         "lined.default.ampm"
  "_mkAMPM _mkSun"          "dotted.default.ampm.sun"
  "_mkLine _mkAMPM _mkSun"  "lined.default.ampm.sun"
)

_combinations_len=${#_combinations[@]}

for _idx in $(seq 0 2 $((_combinations_len-1))); do
  _cmds=${_combinations[_idx]}
  _mvTo=${_combinations[_idx+1]}

  for _cmd in ${_cmds}; do
    ${_cmd}
  done

  createPDFs
  mvDefaultTo "${_mvTo}"
  mv ./*pdf pile

  _restore
done
