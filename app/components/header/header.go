package header

import (
	"strconv"
	"strings"
	"time"

	"github.com/kudrykv/latex-yearly-planner/app/components/hyper"
)

type Header struct {
	Left  Items
	Right Items
}

type Items []Item
type Item interface {
	Display() string
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

type TextItem struct {
	Name      string
	bold      bool
	ref       bool
	refPrefix string
	refText   string
}

func NewTextItem(name string) TextItem {
	return TextItem{
		Name: name,
	}
}

func (t TextItem) Display() string {
	var (
		out string
		ref string
	)
	if t.bold {
		out = "\\textbf{" + t.Name + "}"
	} else {
		out = t.Name
	}

	if len(t.refText) > 0 {
		ref = t.refText
	} else {
		ref = t.refPrefix + t.Name
	}

	if t.ref {
		return hyper.Target(ref, out)
	}

	return hyper.Link(ref, out)
}

func (t TextItem) Ref(ref bool) TextItem {
	t.ref = ref

	return t
}

func (t TextItem) Bold(f bool) TextItem {
	t.bold = f

	return t
}

func (t TextItem) RefPrefix(refPrefix string) TextItem {
	t.refPrefix = refPrefix

	return t
}

func (t TextItem) RefText(refText string) TextItem {
	t.refText = refText

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

type IntItem struct {
	Val int
	ref bool
}

func (i IntItem) Display() string {
	var out string
	s := strconv.Itoa(i.Val)

	if i.ref {
		out = hyper.Target(s, s)
	} else {
		out = hyper.Link(s, s)
	}

	return out
}

func (i IntItem) Ref() IntItem {
	i.ref = true

	return i
}

func NewIntItem(val int) IntItem {
	return IntItem{Val: val}
}

type MonthItem struct {
	Val     time.Month
	ref     bool
	shorten bool
}

func (m MonthItem) Display() string {
	ref := m.Val.String()
	text := ref

	if m.shorten {
		text = text[:3]
	}

	if m.ref {
		return hyper.Target(ref, text)
	}

	return hyper.Link(ref, text)
}

func (m MonthItem) Ref() MonthItem {
	m.ref = true

	return m
}

func (m MonthItem) Shorten(f bool) MonthItem {
	m.shorten = f

	return m
}

func NewMonthItem(m time.Month) MonthItem {
	return MonthItem{Val: m}
}
