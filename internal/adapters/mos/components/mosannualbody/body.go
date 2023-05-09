package mosannualbody

import (
	"bytes"
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosannual"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/tex/texcalendar"
	"strings"
	"text/template"
)

type Body struct {
	templateTree *template.Template
	global       mos.Parameters
}

func New(global mos.Parameters) Body {
	return Body{global: global}
}

func (r Body) GenerateComponent(
	_ context.Context, pageNumber mosannual.PageNumber, sectionParameters mosannual.SectionParameters,
) ([]byte, error) {
	buffer := bytes.NewBuffer(nil)

	littleCalendars := texcalendar.NewCalendarsLittle(r.global.Months)

	from := (pageNumber - 1) * sectionParameters.MonthsPerPage
	to := pageNumber * sectionParameters.MonthsPerPage
	column := 0

	buffer.WriteString(`\begin{tabularx}{\linewidth}{` + strings.Repeat("c", sectionParameters.Columns) + `}` + "\n")

	for _, littleCal := range littleCalendars[from:to] {
		buffer.WriteString(littleCal.String())

		column = (column + 1) % sectionParameters.Columns
		if column == 0 {
			buffer.WriteString(`\\` + "\n")
		} else {
			buffer.WriteString(` & `)
		}
	}

	buffer.WriteString(`\end{tabularx}` + "\n")

	return buffer.Bytes(), nil
}
