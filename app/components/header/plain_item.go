package header

type PlainItem struct {
	Text string
}

func NewPlainItem(text string) PlainItem {
	return PlainItem{Text: text}
}

func (p PlainItem) Display() string {
	return p.Text
}
