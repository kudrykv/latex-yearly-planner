package header

type CellItem struct {
	Text     string
	Ref      string
	selected bool
}

func NewCellItem(text string) CellItem {
	return CellItem{Text: text}
}

func (c CellItem) Select() CellItem {
	c.selected = true

	return c
}

func (c CellItem) Selected(selected bool) CellItem {
	c.selected = selected

	return c
}

func (c CellItem) Refer(ref string) CellItem {
	c.Ref = ref

	return c
}

func (c CellItem) Display() string {
	if c.selected {
		return `\cellcolor{black}{\textcolor{white}{` + c.Text + `}}`
	}

	if len(c.Ref) == 0 {
		c.Ref = c.Text
	}

	return `\hyperlink{` + c.Ref + `}{` + c.Text + `}`
}
