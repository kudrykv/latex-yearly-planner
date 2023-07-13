package mosannualbody

import (
	"bytes"
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosannual"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/tex/tabularxes"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/tex/texcalendar"
	"github.com/kudrykv/latex-yearly-planner/internal/core/entities"
	"text/template"
)

type Body struct {
	templateTree *template.Template

	global              mos.Parameters
	calendarsParameters texcalendar.CalendarLittleParameters
}

func New(global mos.Parameters, calendarsParameters texcalendar.CalendarLittleParameters) Body {
	return Body{
		global:              global,
		calendarsParameters: calendarsParameters,
	}
}

func (r Body) GenerateComponent(
	_ context.Context, pageNumber mosannual.PageNumber, sectionParameters mosannual.SectionParameters,
) ([]byte, error) {
	buffer := bytes.NewBuffer(nil)

	littleCalendars := texcalendar.NewCalendarsLittle(r.global.Months, r.calendarsParameters)

	from := (pageNumber - 1) * sectionParameters.MonthsPerPage
	to := pageNumber * sectionParameters.MonthsPerPage

	if to > len(littleCalendars) {
		to = len(littleCalendars)
	}

	for i := from; i < to; i += sectionParameters.Columns {
		iTo := i + sectionParameters.Columns
		if iTo > to {
			iTo = to
		}

		calTable := tabularxes.New(entities.LineWidth)
		calTable.SetColumnFormat("XX")

		cells := make([]tabularxes.Cell, 0, sectionParameters.Columns)

		for _, littleCal := range littleCalendars[i:iTo] {
			cells = append(cells, tabularxes.Cell{Text: littleCal})
		}

		calTable.AddRow(cells...)
		buffer.WriteString(calTable.Render())

		if iTo < to {
			buffer.WriteString("\n" + `\vfill{}`)
		}
	}

	return buffer.Bytes(), nil
}
