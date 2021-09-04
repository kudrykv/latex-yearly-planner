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
	bold bool
}

func NewTextItem(name string) TextItem {
	return TextItem{
		Name: name,
	}
}

func (t TextItem) Display() string {
	if t.bold {
		return "\\textbf{" + t.Name + "}"
	}

	return t.Name
}

func (t TextItem) Bold(f bool) Item {
	t.bold = f
	return t
}

type ItemsGroup struct {
	Items Items
	delim string
}

func NewItemsGroup(items ...Item) ItemsGroup {
	return ItemsGroup{
		Items: items,
		delim: "\\quad{}",
	}
}

func (i ItemsGroup) Display() string {
	list := make([]string, 0, len(i.Items))

	for _, item := range i.Items {
		list = append(list, item.Display())
	}

	return strings.Join(list, i.delim)
}

func (i ItemsGroup) Delim(delim string) ItemsGroup {
	i.delim = delim

	return i
}
