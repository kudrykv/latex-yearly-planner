#!/bin/bash

# Script to install Go and build the 2026 planner
# This script is designed to run in WSL or Linux

set -e

echo "=== Installing Go ==="

# Check if Go is already installed
if command -v go &> /dev/null; then
    echo "Go is already installed: $(go version)"
else
    echo "Installing Go..."
    cd /tmp
    wget -q https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
    export PATH=$PATH:/usr/local/go/bin
    echo "Go installed: $(go version)"
fi

# Ensure Go is in PATH
export PATH=$PATH:/usr/local/go/bin

echo ""
echo "=== Checking LaTeX installation ==="

# Check if xelatex is installed
if command -v xelatex &> /dev/null; then
    echo "XeLaTeX is installed"
else
    echo "ERROR: XeLaTeX is not installed!"
    echo "Please install TeX Live:"
    echo "  sudo apt-get update"
    echo "  sudo apt-get install texlive-xetex texlive-latex-extra texlive-fonts-recommended"
    exit 1
fi

echo ""
echo "=== Building 2026 Planner ==="

# Navigate to the project directory
cd "/mnt/e/WRITE CD/Jan2026_2/Planner code/latex-yearly-planner-main-ash/latex-yearly-planner-main"

# Build the planner
bash build.sh 2026

echo ""
echo "=== Build Complete ==="
echo "Your planner should be at: planner.2026.pdf"

