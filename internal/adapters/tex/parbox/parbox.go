package parbox

import "fmt"

type Parbox struct {
	Width   fmt.Stringer
	Content fmt.Stringer
}

func New(width fmt.Stringer) Parbox {
	return Parbox{
		Width: width,
	}
}

func (r Parbox) SetContent(stringer fmt.Stringer) Parbox {
	r.Content = stringer

	return r
}

func (r Parbox) Render() string {
	return fmt.Sprintf(`\parbox[t]{%s}{%s}`, r.Width, r.Content)
}
