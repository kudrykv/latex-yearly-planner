package minipage

import "fmt"

type Minipage struct {
	Width   fmt.Stringer
	Content fmt.Stringer
}

func New(width fmt.Stringer) *Minipage {
	return &Minipage{
		Width: width,
	}
}

func (r *Minipage) SetContent(content fmt.Stringer) *Minipage {
	r.Content = content

	return r
}

func (r *Minipage) Render() string {
	return fmt.Sprintf(`\begin{minipage}{%s}%s\end{minipage}`, r.Width, r.Content)
}
