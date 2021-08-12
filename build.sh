#!/usr/bin/env bash
set -eo pipefail

function testCommandExists() {
  for cmd in "$@"; do
    if ! command -v "${cmd}" &>/dev/null; then
      echo "${cmd} could not be found"
      exit
    fi
  done
}

testCommandExists npm node pdflatex
LEFT_HANDED=false
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
  --vendor)
    VENDOR="$2"
    shift
    shift
    ;;

  --planner-year)
    PLANNER_YEAR="$2"
    shift
    shift
    ;;

  --week-start-day)
    WEEK_START_DAY="$2"
    shift
    shift
    ;;

  --disable-weeks)
    DISABLE_WEEKS="$2"
    shift
    shift
    ;;

  --left-handed)
    LEFT_HANDED="$2"
    shift
    shift
    ;;    
  -h | --help)
    echo
    ;;
  esac
done

export VENDOR PLANNER_YEAR WEEK_START_DAY DISABLE_WEEKS LEFT_HANDED

if ! mkdir -p out; then
  echo 'Could not create "out" dir'
  exit 1
fi

if [ ${LEFT_HANDED} == "true" ]; then
  sed -i '/\%right-handed/s/^\\/\%\\/' ./textpl/rm2_ddvk.tex
  sed -i '/\%left-handed/s/^\%//' ./textpl/rm2_ddvk.tex
else
  sed -i '/\%right-handed/s/^\%//' ./textpl/rm2_ddvk.tex
  sed -i '/\%left-handed/s/^\\/\%\\/' ./textpl/rm2_ddvk.tex
fi

npm i
rm tsconfig.tsbuildinfo || true
./node_modules/.bin/tsc
node planner/index.js

if ! cd out; then
  echo 'Could not cd into "out" dir'
  exit 1
fi

pdflatex "${VENDOR}.tex"
mv "${VENDOR}.pdf" "../planner.${PLANNER_YEAR}.${VENDOR}.pdf"

echo -e "\n\nCreated file planner.${PLANNER_YEAR}.${VENDOR}.pdf"
