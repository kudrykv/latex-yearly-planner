# latex-yearly-planner
PDF planner designed for e-ink devices.  
Fork of original project by https://github.com/kudrykv  

## New Features/Changes
Note: Currently, some of these new features are currently designed for the "breadcrumb" variation of the planner, not the "mos" version.  
The "mos" version might not work correctly currently.
1. Option to add multiple Journal pages per day.
2. Option to customize Reflect page contents (spots for Journal location and uploaded status)
3. Option to hide the name of the month above the mini calendar on Daily pages to allow room for more hours on the schedule
4. Option to add a title to the first/Cover page
5. Option to add a key/legend to the Year page (used to indicate which days have a certain property, such as days with journal entries)
6. Added margin and formatting YAML file specific for Remarkable Paper Pro tablet

## Quick Start Guide
Here are the steps to quickly get the project up and running.  
See the `compiled` directory, and also [discussions](https://github.com/kudrykv/latex-yearly-planner/discussions) for prebuilt planners and their variations.

### Building Your Own Planner (on Windows)
#### Install Dependencies
1. [Go Language](https://go.dev/dl/)
2. LaTeX via [MiKTeX](https://miktex.org/howto/install-miktex)

#### Instructions
1. See instructions here for a detailed overview of configuration options and build steps: [How to Build Planner Files for Windows Users…Step-by-Step #94](https://github.com/kudrykv/latex-yearly-planner/discussions/94)
2. You can also run the `compile_planner.bat` script, just replace the directory with your own, and update the .yaml files and xelatex filename according to the instructions above.
3. Check the `out` directory for the generated planner PDF. To move it to your device, follow the manufacturer's instructions on how to load a PDF on your device.

## Preview examples
...Coming soon

...Regular year page
...Key year page
...Quarterly page
...Monthly page
...Weekly page
...Daily page
...Daily Reflect 1, 2, etc pages
...Notes Index page
...Notes page

