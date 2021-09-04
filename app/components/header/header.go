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
	bold bool
	ref  bool
}

func NewTextItem(name string) TextItem {
	return TextItem{
		Name: name,
	}
}

func (t TextItem) Display() string {
	var out string
	if t.bold {
		out = "\\textbf{" + t.Name + "}"
	} else {
		out = t.Name
	}

	if t.ref {
		return hyper.Target(t.Name, out)
	}

	return hyper.Link(out, out)
}

func (t TextItem) Ref(ref bool) TextItem {
	t.ref = ref

	return t
}

func (t TextItem) Bold(f bool) TextItem {
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
	Val time.Month
}

func (m MonthItem) Display() string {
	return m.Val.String()
}

func NewMonthItem(m time.Month) MonthItem {
	return MonthItem{Val: m}
}

type TimeItem struct {
	Val    time.Time
	Layout string
}

func (t TimeItem) Display() string {
	return t.Val.Format(t.Layout)
}

func (t TimeItem) SetLayout(layout string) TimeItem {
	t.Layout = layout

	return t
}

func NewTimeItem(val time.Time) TimeItem {
	return TimeItem{
		Val:    val,
		Layout: time.RFC3339,
	}
}
