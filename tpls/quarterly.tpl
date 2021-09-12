{{- range $j, $month := .Quarter -}}
  {\noindent\renewcommand{\arraystretch}{0}%
\begin{tabularx}{\textwidth}{@{}l X@{}}
{{- template "monthTabular.tpl" dict "Cfg" $.Cfg "Month" $month}} &
\Repeat{\myNumQuarterlyLines}{\myLineGrayVskipBottom}
\end{tabularx}}
{{if ne $j (len $.Quarter)}} \vfill {{end}}
{{end -}}

\pagebreak
