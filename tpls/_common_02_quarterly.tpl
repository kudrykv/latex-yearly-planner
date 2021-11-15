{{- range $j, $month := .Body.Quarter.Months -}}
  {\noindent\renewcommand{\arraystretch}{0}%
\begin{tabularx}{\textwidth}{@{}l X@{}}
{{- template "monthTabularV2.tpl" dict "Month" $month "TableType" "tabular" -}}
  &
  \Repeat{\myNumQuarterlyLines}{\myLineGrayVskipBottom}
\end{tabularx}}
{{if ne $j (len $.Body)}} \vfill {{end}}
{{end -}}