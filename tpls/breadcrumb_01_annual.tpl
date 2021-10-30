{{ template "header_v2.tpl" dict "Cfg" .Cfg "Body" .Body }}

{{range $i, $qrtr := .Body.Year.Quarters}}
\begin{tabularx}{\linewidth}{@{}*{3}{X}@{}}
{{- range $j, $month := $qrtr.Months}}
  \adjustbox{valign=t}{ {{- template "monthTabularV2.tpl" dict "Month" $month -}} }
  {{- if ne $j 2 }} & {{end}}
{{- end }}
\end{tabularx}
{{- if ne $i 3}} \vfill {{- end -}}
{{- end -}}