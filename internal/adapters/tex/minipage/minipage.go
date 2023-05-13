package minipage

import (
	"fmt"
	"github.com/kudrykv/latex-yearly-planner/internal/core/entities"
)

type Minipage struct {
	Content    string
	Parameters Parameters
}

type Parameters struct {
	Width  entities.Length
	Height entities.Length
}

func New(parameters Parameters) *Minipage {
	return &Minipage{
		Parameters: parameters,
	}
}

func (r *Minipage) SetContent(content fmt.Stringer) *Minipage {
	r.Content = content.String()

	return r
}

func (r *Minipage) Add(content fmt.Stringer) *Minipage {
	r.Content += content.String()

	return r
}

func (r *Minipage) AddString(str string) {
	r.Content += str
}

func (r *Minipage) Render() string {
	return fmt.Sprintf(`\begin{minipage}[t][%s]{%s}%s\end{minipage}`, r.Parameters.Height, r.Parameters.Width, r.Content)
}
