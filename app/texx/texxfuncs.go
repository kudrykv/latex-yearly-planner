package texx

import "github.com/kudrykv/latex-yearly-planner/app/tex"

func EmphCell(text string) string {
	return tex.CellColor("black", tex.TextColor("white", text))
}
