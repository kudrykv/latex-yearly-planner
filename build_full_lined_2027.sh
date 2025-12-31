#!/bin/bash
export PATH=$PATH:/usr/local/go/bin

PLANNER_YEAR=2027 \
PASSES=2 \
CFG="cfg/base_lined.yaml,cfg/template_months_on_side.yaml,cfg/sn_a5x.mos.default.yaml" \
NAME="planner.2027.full.lined" \
./single.sh

