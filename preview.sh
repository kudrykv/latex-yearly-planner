#!/bin/bash

# If no target year is passed in though argv[0], use next year as default value
if [ $# -eq 1 ]; then
    TARGET_YEAR=$1
else
    TARGET_YEAR=$(expr $(date +"%Y") + 1)
fi

if [ -z "$CONFIG_FILES" ]; then
  CONFIG_FILES='cfg/base.yaml,cfg/template_months_on_side.yaml,cfg/sn_a5x.mos.default.yaml,cfg/sn_a5x.mos.default.dailycal.yaml'
fi

NAME="planner.${TARGET_YEAR}"

printf "📅 Building $(pwd)/${NAME}.pdf - "

PLANNER_YEAR=${TARGET_YEAR} PASSES=2 CFG=${CONFIG_FILES} NAME=${NAME} PREVIEW=1 ./single.sh >/tmp/$NAME.log &
BUILDER_PID=$!

tail --pid=$BUILDER_PID -f /tmp/$NAME.log | python3 parser.py &
OUTPUT_PID=$!


_exit() {
    if [[ "${STATUS_BUILDER}" -eq 0 && "${STATUS_OUTPUT}" -eq 0 ]]; then
        echo "✅"
        echo "🎉 Successfully built the calendar for ${TARGET_YEAR} 🎉"
    else
        echo "❌"
        echo "⚠️ Error during build process ⚠️"
    fi
}

_term() {
    kill -9 $BUILDER_PID $OUTPUT_PID >/dev/null 2>&1
    # Also kill pdflatex child process
    kill -9 $(ps -e -o pid,comm | grep pdflatex | awk '{print $1}') 1>/dev/null 2>&1
    _exit
}

trap _term EXIT

STATUS_OUTPUT=1
wait $OUTPUT_PID
STATUS_OUTPUT=$?

STATUS_BUILDER=1
wait $BUILDER_PID
STATUS_BUILDER=$?