package header

import "strings"

type Items []Item

func (i Items) WithTopRightCorner(flag bool) Items {
	if !flag {
		return i
	}

	return append(i, NewPlainItem(`\kern 5mm`))
}

func (i Items) Length() int {
	return len(i)
}

func (i Items) ColSetup(left bool) string {
	if left {
		return "|" + strings.Join(strings.Split(strings.Repeat("l", len(i)), ""), "|")
	}

	return strings.Join(strings.Split(strings.Repeat("r", len(i)), ""), "|") + "@{}"
}

func (i Items) Row() string {
	out := make([]string, 0, len(i))

	for _, item := range i {
		out = append(out, item.Display())
	}

	return strings.Join(out, " & ")
}

func (i Items) Table(left bool) string {
	if len(i) == 0 {
		return ""
	}

	return `\begin{tabular}{` + i.ColSetup(left) + `}
` + i.Row() + `
\end{tabular}`
}
