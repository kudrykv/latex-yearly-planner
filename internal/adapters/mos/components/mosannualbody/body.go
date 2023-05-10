package mosannualbody

import (
	"bytes"
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosannual"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/tex/tabularx"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/tex/texcalendar"
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
	columnIndex := 0

	tabular := tabularx.New(LineWidth{})

	var columns tabularx.Cells

	for _, littleCal := range littleCalendars[from:to] {
		columnIndex = (columnIndex + 1) % sectionParameters.Columns
		columns = append(columns, tabularx.Cell{Text: littleCal})

		if columnIndex == 0 {
			tabular.AddRow(columns...)
			columns = nil
		}
	}

	buffer.WriteString(tabular.Render())

	return buffer.Bytes(), nil
}

type LineWidth struct{}

func (LineWidth) String() string {
	return `\linewidth`
}
