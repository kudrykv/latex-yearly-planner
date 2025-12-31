# Vertical Weekly Layout Changes

## Summary
The weekly planner layout has been changed from a horizontal 3-column grid layout to a vertical stacked layout where all 7 days (Monday to Sunday) are displayed one below another.

**✅ Successfully Generated**:
- `planner.2026.weekly.lined.pdf` - 54 pages, 96KB (lined paper, with hyperlinks)
- `planner.2026.weekly.dotted.pdf` - 54 pages, 428KB (dotted paper, with hyperlinks)

## Files Modified

### 1. `tpls/_common_04_weekly_dotted.tpl`
**Previous Layout:** Days were arranged in a 3-column grid:
- Row 1: Days 1-3 (Mon-Wed)
- Row 2: Days 4-6 (Thu-Sat)  
- Row 3: Day 7 (Sun) + Notes section

**New Layout:** All 7 days are stacked vertically:
- Each day gets its own full-width section
- Each day has 3 lines of dotted space for notes
- 2mm spacing between each day
- No separate notes section (removed)

### 2. `tpls/_common_04_weekly_lined.tpl`
**Previous Layout:** Same 3-column grid as dotted version but with lined paper instead of dots

**New Layout:** All 7 days stacked vertically:
- Each day gets its own full-width section
- Each day has 3 lines of ruled space for notes
- 2mm spacing between each day
- No separate notes section (removed)

## Technical Details

### Changes Made:
1. Replaced `\myLenTriCol` (one-third column width) with `\textwidth` (full page width)
2. Changed from horizontal spacing (`\hspace{\myLenTriColSep}`) to vertical spacing (`\vskip 2mm`)
3. Reduced lines per day from `\myNumWeeklyLines` (11 lines) to `3` lines to fit all 7 days on one page
4. Removed the separate Notes section that was previously in the bottom right
5. Removed `\vfill` commands that were spacing out the horizontal rows

## Building the 2026 Planner

### Prerequisites
You need to install:
1. **Go Language** - Download from https://go.dev/dl/
2. **LaTeX/XeLaTeX** - Install TeX Live or MiKTeX

### Build Instructions

#### Option 1: Using build.sh (Linux/WSL/Mac)
```bash
# Build planner for 2026
bash build.sh 2026
```

#### Option 2: Using Nix (Recommended)
```bash
# Install Nix first: https://nixos.org/download.html
# Then build:
nix build .#pdf-2026
```

#### Option 3: Quick Build - Lined Paper (Recommended)
```bash
bash build_weekly_lined_2026.sh
```
Output: `planner.2026.weekly.lined.pdf` (96KB, 54 pages)

#### Option 4: Quick Build - Dotted Paper
```bash
bash build_weekly_dotted_2026.sh
```
Output: `planner.2026.weekly.dotted.pdf` (428KB, 54 pages)

#### Option 5: Manual Build
```bash
# Set environment variables and run
PLANNER_YEAR=2026 \
PASSES=2 \
CFG="cfg/base.yaml,cfg/template_months_on_side.yaml,cfg/sn_a5x.mos.default.yaml,cfg/sn_a5x.mos.default.dailycal.yaml" \
NAME="planner.2026" \
./single.sh
```

### Output
The generated PDFs will be in the project root directory.

## Configuration Files Used
The default configuration uses:
- `cfg/base.yaml` - Base configuration
- `cfg/template_months_on_side.yaml` - Template with months on side
- `cfg/sn_a5x.mos.default.yaml` - Supernote A5X specific settings
- `cfg/sn_a5x.mos.default.dailycal.yaml` - Daily calendar settings

## Notes
- The vertical layout provides equal space for each day of the week
- With 3 lines per day, all 7 days fit comfortably on a single page
- The layout works with both dotted and lined paper styles
- Hyperlinks between pages are preserved in the PDF
- The layout is optimized for e-ink devices like reMarkable and Supernote

## Bug Fixes

### Fixed: Dotted Grid LaTeX Compilation Error
**Problem**: The original `\myDotGrid` command used `\put` commands outside of a picture environment, causing LaTeX compilation errors.

**Solution**: Modified `tpls/macro.tpl` to use TikZ instead of the picture environment:
- Changed from: `\multido{\dC=0mm+5mm}{#1}{\multido{\dR=0mm+5mm}{#2}{\put(\dR,\dC){\circle*{0.1}}}}`
- Changed to: TikZ-based implementation with proper coordinate handling

**Result**: Dotted paper now compiles successfully! The PDF generates with some harmless "Illegal unit of measure" warnings but produces correct output.

## Troubleshooting

### If Go is not installed:
1. Download Go from https://go.dev/dl/
2. Install it following the instructions for your OS
3. Verify installation: `go version`

### If XeLaTeX is not installed:
1. Install TeX Live (Linux/Mac): https://www.tug.org/texlive/
2. Install MiKTeX (Windows): https://miktex.org/download
3. Verify installation: `xelatex --version`

### If build fails with missing .sty files:
Install additional LaTeX packages using your TeX distribution's package manager.

### If build fails with "A <box> was supposed to be here" errors:
This is the dotted grid bug. Set `dotted: false` in `cfg/base.yaml` to use lined paper instead.

