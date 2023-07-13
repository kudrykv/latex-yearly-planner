package mosannualbody

import (
	"bytes"
	"context"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/mos/sections/mosannual"
	"github.com/kudrykv/latex-yearly-planner/internal/adapters/tex/texcalendar"
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

	r.calendarsParameters.Width = sectionParameters.ColumnWidth
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

		for j, littleCal := range littleCalendars[i:iTo] {
			buffer.WriteString(littleCal.String())

			if j < len(littleCalendars[i:iTo])-1 {
				buffer.WriteString(`\hfill{}`)
			}
		}

		if iTo < to {
			if from > 0 && (to-from) < sectionParameters.MonthsPerPage {
				buffer.WriteString("\n\n" + `\vspace{1cm}`)
			} else {
				buffer.WriteString("\n\n" + `\vfill{}`)
			}
		}
	}

	return buffer.Bytes(), nil
}
