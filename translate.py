from typing import Callable
import json


with open("translation.json", "r") as file:
    months, weekdays, weekdays_short, week, notes, note, notes_index, all_notes, schedule, priorities, more, reflect, phrases = json.load(file)

def handle_all() -> None:
    handle_annual()
    handle_quarterly()
    handle_monthly()
    handle_weekly()
    handle_daily()
    handle_daily_reflect()
    handle_daily_notes()
    handle_notes_indexed()

def add_identifier(dict_in: dict[str, str], func: Callable[[str], str]) -> dict[str, str]:
    return {func(index): func(value) for index, value in dict_in.items()}

def handle_annual() -> None:
    with open("out/annual.tex", "r") as file:
        text = file.read()

    replace = add_identifier(months, lambda x: "{" + x + "}}")
    replace |= add_identifier(notes, lambda x: "{" + x + "}")
    for english, spanish in replace.items():
        text = text.replace(english, spanish)

    with open("out/annual.tex", "w") as file:
        file.write(text)

def handle_quarterly() -> None:
    with open("out/quarterly.tex", "r") as file:
        text = file.read()

    replace = add_identifier(months, lambda x: "{" + x + "}}")
    replace |= add_identifier(notes, lambda x: "{" + x + "}")
    for english, spanish in replace.items():
        text = text.replace(english, spanish)

    with open("out/quarterly.tex", "w") as file:
        file.write(text)

def handle_monthly() -> None:
    with open("out/monthly.tex", "r") as file:
        text = file.read()

    replace = add_identifier(months, lambda x: "}{" + x + "}")
    replace |= weekdays
    replace |= add_identifier(week, lambda x: "[c]{" + x)
    for english, spanish in replace.items():
        text = text.replace(english, spanish)

    with open("out/monthly.tex", "w") as file:
        file.write(text)

def handle_weekly() -> None:
    with open("out/weekly.tex", "r") as file:
        text = file.read()

    replace = add_identifier(months, lambda x: "}{" + x + "}")
    replace |= add_identifier(week, lambda x: "}{" + x)
    replace |= add_identifier(weekdays, lambda x: ", " + x + "}")
    replace |= add_identifier(notes, lambda x: "{" + x)
    for english, spanish in replace.items():
        text = text.replace(english, spanish)

    with open("out/weekly.tex", "w") as file:
        file.write(text)

def handle_daily() -> None:
    with open("out/daily.tex", "r") as file:
        text = file.read()

    replace = add_identifier(months, lambda x: "}{" + x + "}")
    replace |= add_identifier(week, lambda x: "}{" + x)
    replace |= add_identifier(weekdays, lambda x: "}{" + x + ",")
    replace |= add_identifier(weekdays_short, lambda x: "}{" + x + ",")
    replace |= add_identifier(schedule, lambda x: "{" + x + "\\")
    replace |= add_identifier(priorities, lambda x: "{" + x + "\\")
    replace |= add_identifier(notes, lambda x: "{" + x + " $")
    replace |= add_identifier(more, lambda x: "{" + x + "}")
    replace |= add_identifier(reflect, lambda x: "{" + x + "}")
    replace |= all_notes
    for english, spanish in replace.items():
        text = text.replace(english, spanish)

    with open("out/daily.tex", "w") as file:
        file.write(text)

def handle_daily_reflect() -> None:
    with open("out/daily_reflect.tex", "r") as file:
        text = file.read()

    replace = add_identifier(months, lambda x: "}{" + x + "}")
    replace |= add_identifier(week, lambda x: "}{" + x)
    replace |= add_identifier(weekdays, lambda x: "}{" + x + ",")
    replace |= add_identifier(weekdays_short, lambda x: "}{" + x + ",")
    replace |= add_identifier(reflect, lambda x: "{" + x + "}")
    replace |= phrases
    for english, spanish in replace.items():
        text = text.replace(english, spanish)

    with open("out/daily_reflect.tex", "w") as file:
        file.write(text)

def handle_daily_notes() -> None:
    with open("out/daily_notes.tex", "r") as file:
        text = file.read()

    replace = add_identifier(months, lambda x: "}{" + x + "}")
    replace |= add_identifier(week, lambda x: "}{" + x)
    replace |= add_identifier(weekdays, lambda x: "}{" + x + ",")
    replace |= add_identifier(weekdays_short, lambda x: "}{" + x + ",")
    replace |= add_identifier(notes, lambda x: "{" + x + "}")
    for english, spanish in replace.items():
        text = text.replace(english, spanish)

    with open("out/daily_notes.tex", "w") as file:
        file.write(text)

def handle_notes_indexed() -> None:
    with open("out/notes_indexed.tex", "r") as file:
        text = file.read()

    replace = add_identifier(notes_index, lambda x: "}{" + x)
    replace |= add_identifier(note, lambda x: "}{" + x)
    for english, spanish in replace.items():
        text = text.replace(english, spanish)

    with open("out/notes_indexed.tex", "w") as file:
        file.write(text)

handle_all()
