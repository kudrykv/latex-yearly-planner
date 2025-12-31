#!/bin/bash
export PATH=$PATH:/usr/local/go/bin

PLANNER_YEAR=2026 \
PASSES=2 \
CFG="cfg/base.yaml,cfg/template_months_on_side.yaml,cfg/sn_a5x.mos.default.yaml" \
NAME="planner.2026.full.dotted" \
./single.sh

