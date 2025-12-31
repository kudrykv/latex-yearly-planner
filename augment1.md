This is a **LaTeX Yearly Planner** project that generates PDF planners optimized for e-ink devices. Here's a brief overview:

## What it does
- Generates customizable yearly planners as PDFs using LaTeX
- Designed specifically for e-ink devices like reMarkable tablets
- Supports multiple planner layouts and templates

## Key Features
- **Multiple planner types**: Annual, quarterly, monthly, weekly, and daily views
- **Configurable layouts**: Different paper sizes (A5X, etc.) and templates
- **Modular design**: Uses YAML configuration files to customize output
- **Preview mode**: Generate sample pages without full planner

## Tech Stack
- **Go**: Main application logic (`app/app.go`, `cmd/plannergen/plannergen.go`)
- **LaTeX/XeLaTeX**: PDF generation using templates in `tpls/` directory
- **YAML**: Configuration system (`cfg/` directory)
- **Nix**: Reproducible build environment with fixed dependencies

## Usage
The project provides shell scripts like `build.sh` and `preview.sh` that orchestrate the build process. Users can specify the target year and configuration files to generate their desired planner format.

The project appears to be actively maintained with CI/CD through GitHub Actions and supports building planners for multiple years (2025-2030 currently configured).

---

