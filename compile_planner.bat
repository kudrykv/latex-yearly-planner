@echo off

REM Change to the project directory
cd C:\Users\hyder\OneDrive\Documents\GitHub\latex-yearly-planner

REM Set the year environment variable
set PLANNER_YEAR=2024

REM Run the Go command with logging
echo Running Go command...
go run cmd/plannergen/plannergen.go --config "cfg/base.yaml,cfg/rmpp.base.yaml,cfg/template_breadcrumb.yaml,cfg/rm2.breadcrumb.default.yaml,cfg/rm2.breadcrumb.default.dailycal.yaml,cfg/rmpp.breadcrumb.lined.default.ampm.dailycal.reflectextra.yaml"
IF %ERRORLEVEL% NEQ 0 (
    echo Error running Go command
    exit /b %ERRORLEVEL%
)

REM Change to the output directory
cd out

REM Run the xelatex commands
echo Running xelatex (1/2)...
call xelatex -quiet rmpp.breadcrumb.lined.default.ampm.dailycal.reflectextra
IF %ERRORLEVEL% NEQ 0 (
    echo Error running xelatex (1/2)
)

timeout /t 2 >nul

echo Running xelatex (2/2)...
call xelatex -quiet rmpp.breadcrumb.lined.default.ampm.dailycal.reflectextra
IF %ERRORLEVEL% NEQ 0 (
    echo Error running xelatex (2/2)
)

echo Script completed successfully.
echo Press any key to exit...
set /p dummyVar="> "
