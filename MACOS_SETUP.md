# macOS Setup Guide

This guide will help you install all the necessary tools to run this project on macOS.

## Required Tools

### 1. Go Language (Required)
**Version:** Go 1.16 or later

**Installation Options:**

**Option A: Using Homebrew (Recommended)**
```bash
brew install go
```

**Option B: Direct Download**
- Visit https://go.dev/dl/
- Download the macOS installer (.pkg file)
- Run the installer and follow the prompts

**Verify Installation:**
```bash
go version
```

---

### 2. LaTeX Distribution with XeLaTeX (Required)
**Why:** The project uses `xelatex` to compile PDFs from generated LaTeX files.

**Installation Options:**

**Option A: MacTeX (Full Distribution - ~4GB)**
- Visit https://www.tug.org/mactex/
- Download and install MacTeX
- This includes XeLaTeX and all necessary LaTeX packages

**Option B: BasicTeX + Manual Package Installation (~100MB)**
```bash
brew install --cask basictex
# After installation, update tlmgr and install required packages
sudo tlmgr update --self
sudo tlmgr install xcolor pgf wrapfig makecell multirow leading marginnote adjustbox multido varwidth blindtext setspace ifmtarg extsizes dashrule
```

**Option C: Using Homebrew (MacTeX)**
```bash
brew install --cask mactex
```

**Verify Installation:**
```bash
xelatex --version
```

**Note:** After installing MacTeX or BasicTeX, you may need to restart your terminal or run:
```bash
eval "$(/usr/libexec/path_helper)"
```

---

### 3. Python 3 (Required)
**Status:** Usually pre-installed on macOS

**Check if installed:**
```bash
python3 --version
```

**If not installed, install via Homebrew:**
```bash
brew install python3
```

**Note:** The Python scripts (`parser.py`, `translate.py`) only use standard library modules, so no additional packages need to be installed.

---

## Optional Tools

### Homebrew (Package Manager)
If you don't have Homebrew installed, it makes installing the above tools easier:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

---

## Quick Installation (All-in-One)

If you have Homebrew installed, you can install everything with:

```bash
# Install Go
brew install go

# Install MacTeX (full LaTeX distribution)
brew install --cask mactex

# Python 3 should already be installed, but if not:
brew install python3
```

**Note:** MacTeX is a large download (~4GB) and installation. The installation process may take 15-30 minutes.

---

## Verify Your Setup

After installing all tools, verify everything works:

```bash
# Check Go
go version

# Check XeLaTeX
xelatex --version

# Check Python
python3 --version
```

---

## Test the Project

Once everything is installed, you can test the project:

```bash
# Make sure the shell script is executable
chmod +x compile_planner.sh

# Run the compilation script
./compile_planner.sh
```

Or use the other build scripts:
```bash
./build.sh 2024        # Build for year 2024
./preview.sh 2024      # Preview for year 2024
```

---

## Troubleshooting

### XeLaTeX not found
If `xelatex` command is not found after installation:
1. Restart your terminal
2. Or run: `eval "$(/usr/libexec/path_helper)"`
3. Or add to your `~/.zshrc`: `export PATH="/usr/local/texlive/2024/bin/universal-darwin:$PATH"` (adjust year as needed)

### Go modules not downloading
If Go can't download dependencies:
- Check your internet connection
- Run: `go mod download`

### Permission errors
If you get permission errors with LaTeX packages:
- Use `sudo` when running `tlmgr` commands
- Or install MacTeX (full version) which doesn't require manual package management

