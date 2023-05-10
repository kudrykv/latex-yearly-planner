package mosannualbody

import (
	"bytes"
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosannual"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/tex/minipage"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/tex/texcalendar"
	"github.com/kudrykv/latex-yearly-planner/internal/core/entities"
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

	for i, littleCal := range littleCalendars[from:to] {
		columnIndex = (columnIndex + 1) % sectionParameters.Columns
		buffer.WriteString(minipage.New(5 * entities.Centimeter).SetContent(littleCal).Render())

		if columnIndex == 0 {
			buffer.WriteString("\n\n")

			if i+1 != sectionParameters.MonthsPerPage {
				buffer.WriteString(`\vfill{}` + "\n")
			}
		}
	}

	return buffer.Bytes(), nil
}
