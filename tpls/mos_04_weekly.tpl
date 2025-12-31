{{- .Body.HeadingMOS -}}
\hfill
{{- range $i, $month := .Body.Week.Months -}}
{{- if $i }} / {{ end -}}
\hyperlink{ {{- $month.Month.String -}} }{ {{- $month.Month.String -}} }
{{- end -}}
\hfill
{\renewcommand{\arraystretch}{\myNumArrayStretch} {{ .Body.Extra2.Table false }} }%
\medskip%
\myLineThick%
\medskip
{{ template "_common_04_weekly.tpl" dict "Cfg" .Cfg "Body" .Body }}

\pagebreak
