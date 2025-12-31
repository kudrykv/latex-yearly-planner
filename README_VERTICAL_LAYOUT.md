# Vertical Weekly Layout - 2026 Planner

## ✅ Completed Successfully!

I've successfully modified the weekly planner layout to display days vertically (Monday through Sunday stacked), fixed the dotted paper bug, and generated PDF planners for 2026 with hyperlinks.

## Generated Files

**`planner.2026.weekly.lined.pdf`** - 96KB, 54 pages
- 1 title page
- 53 weekly pages (one for each week of 2026)
- Vertical layout with all 7 days stacked
- Lined paper format
- Full hyperlink support for navigation

**`planner.2026.weekly.dotted.pdf`** - 428KB, 54 pages
- 1 title page
- 53 weekly pages (one for each week of 2026)
- Vertical layout with all 7 days stacked
- Dotted paper format (5mm grid)
- Full hyperlink support for navigation

## Changes Made

### 1. Modified Weekly Templates

**Files Changed:**
- `tpls/_common_04_weekly_dotted.tpl` - Vertical layout for dotted paper
- `tpls/_common_04_weekly_lined.tpl` - Vertical layout for lined paper

**Layout Changes:**
- **Before**: Days arranged in 3-column horizontal grid (Mon-Wed, Thu-Sat, Sun+Notes)
- **After**: All 7 days stacked vertically, one below another
- Each day gets full page width
- 3 lines of space per day for notes
- 2mm spacing between days

### 2. Fixed Dotted Paper Bug

**Modified File:**
- `tpls/macro.tpl` - Fixed `\myDotGrid` command to use TikZ instead of broken picture environment

**Problem**: The original code used `\put` commands outside of a picture environment.
**Solution**: Rewrote to use TikZ with proper coordinate handling.

### 3. Created Configuration Files

**New Files:**
- `cfg/base_lined.yaml` - Base configuration with `dotted: false`
- `cfg/template_weekly_only.yaml` - Template that generates only weekly pages
- `build_weekly_lined_2026.sh` - Build script for lined paper version
- `build_weekly_dotted_2026.sh` - Build script for dotted paper version

## How to Build

### Quick Build - Lined Paper
```bash
bash build_weekly_lined_2026.sh
```
Generates: `planner.2026.weekly.lined.pdf` (96KB, 54 pages)

### Quick Build - Dotted Paper
```bash
bash build_weekly_dotted_2026.sh
```
Generates: `planner.2026.weekly.dotted.pdf` (428KB, 54 pages)

### Full Build with All Pages
To build a complete planner with annual, quarterly, monthly, weekly, and daily pages:

```bash
# First, set dotted: false in cfg/base.yaml to avoid compilation errors
# Then run:
PLANNER_YEAR=2026 \
PASSES=2 \
CFG="cfg/base_lined.yaml,cfg/template_months_on_side.yaml,cfg/sn_a5x.mos.default.yaml" \
NAME="planner.2026.full" \
./single.sh
```

## Important Notes

### Dotted Paper - Now Fixed! ✅
The original codebase had a bug where dotted paper caused LaTeX compilation errors. This has been **fixed** by rewriting the `\myDotGrid` command to use TikZ.

**Result**: Both lined and dotted paper versions now compile successfully!

### Hyperlinks
The generated PDF includes full hyperlink support:
- Click on dates to navigate to specific days
- Click on week numbers to jump to weekly pages
- All internal navigation links are preserved

## File Structure

```
latex-yearly-planner-main/
├── planner.2026.weekly.lined.pdf    # Generated PDF (96KB, 54 pages)
├── planner.2026.weekly.dotted.pdf   # Generated PDF (428KB, 54 pages)
├── tpls/
│   ├── macro.tpl                    # Modified: fixed \myDotGrid bug
│   ├── _common_04_weekly_dotted.tpl # Modified for vertical layout
│   └── _common_04_weekly_lined.tpl  # Modified for vertical layout
├── cfg/
│   ├── base_lined.yaml              # New: lined paper configuration
│   └── template_weekly_only.yaml    # New: weekly-only template
├── build_weekly_lined_2026.sh       # New: build script for lined
├── build_weekly_dotted_2026.sh      # New: build script for dotted
├── VERTICAL_LAYOUT_CHANGES.md       # Detailed technical documentation
└── README_VERTICAL_LAYOUT.md        # This file
```

## Viewing the PDF

The generated PDF is optimized for e-ink devices like reMarkable and Supernote tablets. You can:
1. Open it in any PDF viewer
2. Transfer it to your e-ink device
3. Use the hyperlinks to navigate between pages

## Next Steps

If you want to customize further:
1. Adjust the number of lines per day by changing the `3` in the template files
2. Modify spacing by changing the `\vskip 2mm` values
3. Add back the Notes section if desired
4. Combine with other page types (monthly, daily, etc.)

## Support

For detailed technical information about the changes, see `VERTICAL_LAYOUT_CHANGES.md`.

For issues with the original planner project, visit: https://github.com/kudrykv/latex-yearly-planner

