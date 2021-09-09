{{- template "header.tpl" dict "Cfg" $.Cfg "Header" .Header -}}

{{- $save := . -}}
{{- range $j, $month := .Body.Quarter -}}
  {\noindent\renewcommand{\arraystretch}{0}%
  \begin{tabularx}{\textwidth}{@{}l X@{}}
  {{- template "monthTabular.tpl" dict "Cfg" $.Cfg "Month" $month}} &
  \Repeat{\myNumQuarterlyLines}{\myLineGrayVskipBottom}
  \end{tabularx}}
  {{if ne $j (len $save.Body.Quarter)}} \vfill {{end}}
{{end -}}

\pagebreak
