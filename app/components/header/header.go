package header

import "strings"

type Header struct {
	Left  Items
	Right Items
}

type Items []Item
type Item interface {
	Display() string
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

type TextItem struct {
	Name string
	Link string
	Ref  string
}

func NewTextItem(name string) TextItem {
	return TextItem{
		Name: name,
	}
}

func (t TextItem) Display() string {
	return t.Name
}
