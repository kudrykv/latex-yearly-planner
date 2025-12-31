#!/bin/bash
export PATH=$PATH:/usr/local/go/bin

PLANNER_YEAR=2026 \
PASSES=2 \
CFG="cfg/base.yaml,cfg/template_weekly_only.yaml,cfg/sn_a5x.mos.default.yaml" \
NAME="planner.2026.weekly" \
./single.sh

