package tex

import (
	"fmt"
	"strings"
)

const nl = "\n"

func CellColor(color, text string) string {
	return fmt.Sprintf(`\cellcolor{%s}{%s}`, color, text)
}

func TextColor(color, text string) string {
	return fmt.Sprintf(`\textcolor{%s}{%s}`, color, text)
}

func Hyperlink(ref, text string) string {
	return fmt.Sprintf(`\hyperlink{%s}{%s}`, ref, text)
}

func Hypertarget(ref, text string) string {
	return fmt.Sprintf(`\hypertarget{%s}{%s}`, ref, text)
}

func Tabular(format, text string) string {
	return `\begin{tabular}{` + format + `}` + nl + text + nl + `\end{tabular}`
}

func ResizeBoxW(width, text string) string {
	return fmt.Sprintf(`\resizebox{!}{%s}{%s}`, width, text)
}

func Multirow(rows int, text string) string {
	return fmt.Sprintf(`\multirow{%d}{*}{%s}`, rows, text)
}

func Bold(text string) string {
	return fmt.Sprintf(`\textbf{%s}`, text)
}

func escapeLatex(s string) string {
	replacements := map[string]string{
		"&":  "\\&",
		"%":  "\\%",
		"$":  "\\$",
		"#":  "\\#",
		"_":  "\\_",
		"{":  "\\{",
		"}":  "\\}",
		"~":  "\\textasciitilde",
		"^":  "\\textasciicircum",
		"\\": "\\textbackslash",
	}

	for old, new := range replacements {
		s = strings.ReplaceAll(s, old, new)
	}
	return s
}
