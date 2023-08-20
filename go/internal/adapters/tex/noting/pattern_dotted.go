package noting

import "fmt"

type PatternDotted struct{}

func (r PatternDotted) Render(width Width, height Height) string {
	return fmt.Sprintf(texPatternFormatDotted, width, height)
}

const texPatternFormatDotted = `\begin{tikzpicture}
\fill [pattern=custom_dotted] (0,0) rectangle (%s,%s);
\end{tikzpicture}`
