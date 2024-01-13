from typing import Callable
import json
from sys import argv

language = argv[1].lower()

with open("translations.json", "r") as file:
    translations = json.load(file)

if any(language in key for key in translations.keys()):
    translation = translations.get(language)
else:
    raise ValueError("Requested translation is not currently supported.\nThe program will now exit.")


if any(not word.isascii() for word in translation.values()):
    font_edit = r"" # Do something here to fonts
else:
    font_edit = ""
print(f"Translating pdf to {language}")

MONTHS = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
WEEKDAYS = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
WEEKDAYS_SHORT = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
WEEK = ["Week"]
NOTES = ["Notes"]
NOTE = ["Note"]
NOTES_INDEX = ["Notes Index"]
ALL_NOTES = ["All notes"]
SCHEDULE = ["Schedule"]
PRIORITIES = ["Top priorities"]
MORE = ["More"]
REFLECT = ["Reflect"]
PHRASES = ["Things I'm grateful for", "The best thing that happened today", "Daily log"]

def handle_all() -> None:
    handle_annual()
    handle_quarterly()
    handle_monthly()
    handle_weekly()
    handle_daily()
    handle_daily_reflect()
    handle_daily_notes()
    handle_notes_indexed()

def add_identifier(keys: list[str], func: Callable[[str], str] = lambda x: x, dictionary: dict[str, str] = translation) -> dict[str, str]:
    return {func(key): func(dictionary.get(key)) for key in keys}

def handle_annual() -> None:
    with open("out/annual.tex", "r") as file:
        text = file.read()

    replace = add_identifier(MONTHS, lambda x: "{" + x + "}}")
    replace |= add_identifier(NOTES, lambda x: "{" + x + "}")
    for english, spanish in replace.items():
        text = text.replace(english, spanish)

    with open("out/annual.tex", "w") as file:
        file.write(font_edit)
        file.write(text)

def handle_quarterly() -> None:
    with open("out/quarterly.tex", "r") as file:
        text = file.read()

    replace = add_identifier(MONTHS, lambda x: "{" + x + "}}")
    replace |= add_identifier(NOTES, lambda x: "{" + x + "}")
    for english, spanish in replace.items():
        text = text.replace(english, spanish)

    with open("out/quarterly.tex", "w") as file:
        file.write(font_edit)
        file.write(text)

def handle_monthly() -> None:
    with open("out/monthly.tex", "r") as file:
        text = file.read()

    replace = add_identifier(MONTHS, lambda x: "}{" + x + "}")
    replace |= add_identifier(WEEKDAYS)
    replace |= add_identifier(WEEK, lambda x: "[c]{" + x)
    for english, spanish in replace.items():
        text = text.replace(english, spanish)

    with open("out/monthly.tex", "w") as file:
        file.write(font_edit)
        file.write(text)

def handle_weekly() -> None:
    with open("out/weekly.tex", "r") as file:
        text = file.read()

    replace = add_identifier(MONTHS, lambda x: "}{" + x + "}")
    replace |= add_identifier(WEEK, lambda x: "}{" + x)
    replace |= add_identifier(WEEKDAYS, lambda x: ", " + x + "}")
    replace |= add_identifier(NOTES, lambda x: "{" + x)
    for english, spanish in replace.items():
        text = text.replace(english, spanish)

    with open("out/weekly.tex", "w") as file:
        file.write(font_edit)
        file.write(text)

def handle_daily() -> None:
    with open("out/daily.tex", "r") as file:
        text = file.read()

    replace = add_identifier(MONTHS, lambda x: "}{" + x + "}")
    replace |= add_identifier(WEEK, lambda x: "}{" + x)
    replace |= add_identifier(WEEKDAYS, lambda x: "}{" + x + ",")
    replace |= add_identifier(WEEKDAYS_SHORT, lambda x: "}{" + x + ",")
    replace |= add_identifier(SCHEDULE, lambda x: "{" + x + "\\")
    replace |= add_identifier(PRIORITIES, lambda x: "{" + x + "\\")
    replace |= add_identifier(NOTES, lambda x: "{" + x + " $")
    replace |= add_identifier(MORE, lambda x: "{" + x + "}")
    replace |= add_identifier(REFLECT, lambda x: "{" + x + "}")
    replace |= add_identifier(ALL_NOTES)
    for english, spanish in replace.items():
        text = text.replace(english, spanish)

    with open("out/daily.tex", "w") as file:
        file.write(font_edit)
        file.write(text)

def handle_daily_reflect() -> None:
    with open("out/daily_reflect.tex", "r") as file:
        text = file.read()

    replace = add_identifier(MONTHS, lambda x: "}{" + x + "}")
    replace |= add_identifier(WEEK, lambda x: "}{" + x)
    replace |= add_identifier(WEEKDAYS, lambda x: "}{" + x + ",")
    replace |= add_identifier(WEEKDAYS_SHORT, lambda x: "}{" + x + ",")
    replace |= add_identifier(REFLECT, lambda x: "{" + x + "}")
    replace |= add_identifier(PHRASES)
    for english, spanish in replace.items():
        text = text.replace(english, spanish)

    with open("out/daily_reflect.tex", "w") as file:
        file.write(font_edit)
        file.write(text)

def handle_daily_notes() -> None:
    with open("out/daily_notes.tex", "r") as file:
        text = file.read()

    replace = add_identifier(MONTHS, lambda x: "}{" + x + "}")
    replace |= add_identifier(WEEK, lambda x: "}{" + x)
    replace |= add_identifier(WEEKDAYS, lambda x: "}{" + x + ",")
    replace |= add_identifier(WEEKDAYS_SHORT, lambda x: "}{" + x + ",")
    replace |= add_identifier(NOTES, lambda x: "{" + x + "}")
    for english, spanish in replace.items():
        text = text.replace(english, spanish)

    with open("out/daily_notes.tex", "w") as file:
        file.write(font_edit)
        file.write(text)

def handle_notes_indexed() -> None:
    with open("out/notes_indexed.tex", "r") as file:
        text = file.read()

    replace = add_identifier(NOTES_INDEX, lambda x: "}{" + x)
    replace |= add_identifier(NOTE, lambda x: "}{" + x)
    for english, spanish in replace.items():
        text = text.replace(english, spanish)

    with open("out/notes_indexed.tex", "w") as file:
        file.write(font_edit)
        file.write(text)

handle_all()
