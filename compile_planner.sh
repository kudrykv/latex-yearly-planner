#!/bin/bash

# Change to the project directory (using the script's directory)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Set the year environment variable
export PLANNER_YEAR=2025

# Create output directory if it doesn't exist
mkdir -p out

# Run the Go command with logging
echo "Running Go command..."
if ! go run cmd/plannergen/plannergen.go --config "cfg/base.yaml,cfg/rmpp.base.yaml,cfg/template_breadcrumb.yaml,cfg/rm2.breadcrumb.default.yaml,cfg/rm2.breadcrumb.default.dailycal.yaml,cfg/rmpp.breadcrumb.lined.default.ampm.dailycal.reflectextra.yaml"; then
    echo "Error running Go command"
    exit 1
fi

# Change to the output directory
cd out

# Run the xelatex commands
echo "Running xelatex (1/2)..."
xelatex -quiet rmpp.breadcrumb.lined.default.ampm.dailycal.reflectextra
if [ $? -ne 0 ]; then
    echo "Error running xelatex (1/2)"
fi

sleep 2

echo "Running xelatex (2/2)..."
xelatex -quiet rmpp.breadcrumb.lined.default.ampm.dailycal.reflectextra
if [ $? -ne 0 ]; then
    echo "Error running xelatex (2/2)"
fi

echo "Script completed successfully."
echo "Press Enter to exit..."
read dummyVar

