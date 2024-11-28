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
![01_annual](https://github.com/user-attachments/assets/a3cbc19a-b38c-473e-8a9d-b958e387497e)
![01_annual_key](https://github.com/user-attachments/assets/bdbf3b33-30ea-4704-b9fe-69c82c274456)
![02_quarterly](https://github.com/user-attachments/assets/044ef1b4-a9aa-4e2b-9d53-f6511d7d605b)
![03_monthly](https://github.com/user-attachments/assets/437c9c47-ea99-4047-a3c4-a73204e81e8b)
![04_weekly](https://github.com/user-attachments/assets/e9e0ef82-e66a-432a-81ec-89ff590b5c7b)
![05_daily](https://github.com/user-attachments/assets/1218b4c6-92bc-4123-baa0-580b96a1283c)
![06_daily_reflect](https://github.com/user-attachments/assets/08dbb57e-d141-43bb-a04b-f5ac3886401b)
![06_daily_reflect_extended](https://github.com/user-attachments/assets/34c4f5cc-001d-44d9-8db1-3d08285de3f6)
![07_daily_notes](https://github.com/user-attachments/assets/5c8abd17-4f49-4484-9244-b43e6963ae59)
![08_notes_index](https://github.com/user-attachments/assets/ac1a6563-bc11-4a59-be15-db33d4284fae)
![09_notes](https://github.com/user-attachments/assets/c7f63cea-2b3c-401d-8d5a-c43bc05397d3)


