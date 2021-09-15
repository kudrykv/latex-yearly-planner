package header

type CellItem struct {
	Text     string
	Ref      string
	Selected bool
}

func NewCellItem(text string) CellItem {
	return CellItem{Text: text}
}

func (c CellItem) Select() CellItem {
	c.Selected = true

	return c
}

func (c CellItem) Refer(ref string) CellItem {
	c.Ref = ref

	return c
}

func (c CellItem) Display() string {
	if c.Selected {
		return `\cellcolor{black}{\color{white}{` + c.Text + `}}`
	}

	if len(c.Ref) == 0 {
		c.Ref = c.Text
	}

	return `\hyperlink{` + c.Ref + `}{` + c.Text + `}`
}
