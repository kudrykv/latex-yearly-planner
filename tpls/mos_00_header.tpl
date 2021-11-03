{{- .Body.HeadingMOS -}}
{}\hfill%
{\renewcommand{\arraystretch}{\myNumArrayStretch}%
  \begin{tabular}{*{ {{- len .Body.Extra2 -}} }{c|}@{}{{if .Cfg.ClearTopRightCorner}}c@{}{{end}}}
  {{range $i, $cell := .Body.Extra2}}
  {{$cell.Display}} {{ if not (eq (incr $i) (len $.Body.Extra2)) }}
    & {{end}}
    {{end}}
    {{- if .Cfg.ClearTopRightCorner}}& \hspace{7mm}{{end}}
  \end{tabular}}%
\medskip%
\myLineThick%
\marginnote{%
  \rotatebox[origin=tr]{90}{%
    \renewcommand{\arraystretch}{2}%
    \begin{tabularx}{\myLenHeaderSideMonthsWidth}{*{11}{Y|}Y}
      \hline
      {{range $i, $month := .Body.SideMonths -}}
      {{$month.Display}} {{if ne $i 11}}
      & {{else}} \\{{- $.Cfg.Layout.Lengths.HeaderSideCellHeight -}} \hline {{end}}
    {{end}}
    \end{tabularx}%
    \quad%
    \begin{tabularx}{\myLenHeaderSideQuartersWidth}{*{3}{Y|}Y}
      \hline
      {{range $i, $quarter := .Body.SideQuarters -}}
      {{$quarter.Display}} {{if ne $i 3}}
      & {{else}} \\{{- $.Cfg.Layout.Lengths.HeaderSideCellHeight -}} \hline {{end}}
    {{end}}
    \end{tabularx}%
  }%
}%
\medskip
