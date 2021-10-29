{{ template "header_v2.tpl" dict "Cfg" .Cfg "Body" .Body }}

{{- range $j, $month := .Body.Quarter -}}
  {\noindent\renewcommand{\arraystretch}{0}%
\begin{tabularx}{\textwidth}{@{}l X@{}}
{{- template "monthTabular.tpl" dict "Cfg" $.Cfg "Month" $month}} &
\Repeat{\myNumQuarterlyLines}{\myLineGrayVskipBottom}
\end{tabularx}}
{{if ne $j (len $.Body)}} \vfill {{end}}
{{end -}}

\pagebreak