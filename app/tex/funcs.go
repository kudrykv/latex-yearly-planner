package tex

import "fmt"

func CellColor(color, text string) string {
	return fmt.Sprintf(`\cellcolor{%s}{%s}`, color, text)
}

func TextColor(color, text string) string {
	return fmt.Sprintf(`\textcolor{%s}{%s}`, color, text)
}

func Hyperlink(ref, text string) string {
	return fmt.Sprintf(`\hyperlink{%s}{%s}`, ref, text)
}
