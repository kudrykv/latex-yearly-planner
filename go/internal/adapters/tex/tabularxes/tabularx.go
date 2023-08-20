package tabularxes

import (
	"fmt"
	"strings"
)

type Tabularx struct {
	Width           fmt.Stringer
	Rows            Rows
	HeaderName      string
	ColumnFormat    string
	HorizontalLines bool
}

type Row struct {
	Cells Cells
}

type Rows []Row

type Cell struct {
	Text fmt.Stringer
}

type Cells []Cell

func New(width fmt.Stringer) *Tabularx {
	return &Tabularx{
		Width: width,
	}
}

func (r *Tabularx) AddRow(cells ...Cell) {
	r.Rows = append(r.Rows, Row{Cells: cells})
}

func (r *Tabularx) Render() string {
	return fmt.Sprintf(`{\renewcommand{\arraystretch}{1}\setlength{\tabcolsep}{0mm}%%
\begin{tabularx}{%s}[t]{%s}
%s%s
\end{tabularx}}`,
		r.Width,
		r.columnFormat(),
		r.headerCenterName(),
		r.rows(),
	)
}

func (r *Tabularx) columnFormat() string {
	if r.ColumnFormat != "" {
		return r.ColumnFormat
	}

	return strings.Repeat("Y", len(r.Rows[0].Cells))
}

func (r *Tabularx) rows() string {
	var rows []string

	for _, row := range r.Rows {
		var cells []string
		for _, cell := range row.Cells {
			cells = append(cells, "{"+cell.Text.String()+"}")
		}

		rows = append(rows, strings.Join(cells, " & "))
	}

	separator := `\\`
	if r.HorizontalLines {
		separator += ` \hline`
	}

	separator += "\n"

	rowData := strings.Join(rows, separator)

	if r.HorizontalLines {
		rowData = `\hline` + "\n" + rowData + `\\ \hline` + "\n"
	}

	return rowData
}

func (r *Tabularx) SetHeaderName(headerName string) {
	r.HeaderName = headerName
}

func (r *Tabularx) headerCenterName() string {
	if r.HeaderName == "" {
		return ""
	}

	return fmt.Sprintf(`\multicolumn{%d}{c}{%s}\\`+"\n", len(r.Rows[0].Cells), r.HeaderName)
}

func (r *Tabularx) SetColumnFormat(columnFormat string) {
	r.ColumnFormat = columnFormat
}

func (r *Tabularx) SetHorizontalLines(horizontalLines bool) {
	r.HorizontalLines = horizontalLines
}
