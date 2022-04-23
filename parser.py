import signal
import sys

# Read stdin for \[[0-9]+(?:\/[0-9]+)?\]
START_CHAR = "["
END_CHAR = "]"


class Printer:
    passes = 1
    prevous_page = -1
    prevous_string = ""
    denominator = 0

    def emit(self, page_number):
        # set denominator if page_number < last_page_number
        if page_number < self.prevous_page:
            self.denominator = self.prevous_page
            self.passes += 1

        self.prevous_page = page_number
        current_string = f"processing (pass={self.passes}): {page_number}"

        if self.denominator:
            current_string += f"/{self.denominator}"

        # Add |b for prevous_string length
        current_string = "\b" * len(self.prevous_string) + current_string
        self.prevous_string = current_string[len(self.prevous_string) :]

        print(current_string, end="")
        sys.stdout.flush()

    def clear(self):
        print(
            "\b" * len(self.prevous_string)
            + " " * len(self.prevous_string)
            + "\b" * len(self.prevous_string),
            end="",
        )
        sys.stdout.flush()


try:
    stored = ""
    buff = ""
    printer = Printer()
    while True:
        buff = sys.stdin.read(1)

        # Exit once stding is empty
        if buff == "":
            printer.clear()
            break

        # Page numbers are delimited by square brakets like: [<number>]

        # Once the ] character is matched, emit the stored number
        if buff == "]" and len(stored) > 1:
            printer.emit(int(stored[1:]))

        # Save the number between square brackets
        elif len(stored) > 0 and buff != "]":
            try:
                int(buff)
                stored += buff
            except:
                stored = ""

        # Mark number start
        elif buff == "[":
            stored = "["

        # Empty stored buffer on mismatch
        else:
            stored = ""

except KeyboardInterrupt:
    exit(1)
