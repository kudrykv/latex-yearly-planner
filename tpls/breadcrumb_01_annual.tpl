{{ template "header_v2.tpl" dict "Cfg" .Cfg "Body" .Body }}

{{range $i, $qrtr := .Body.Quarters}}
\begin{tabularx}{\linewidth}{@{}*{3}{X}@{}}
{{- range $j, $month := $qrtr}}
    \adjustbox{valign=t}{ {{- template "monthTabular.tpl" dict "Cfg" $.Cfg "Month" $month "UseTabularx" true -}} }
{{- if ne $j 2 }} & {{end}}
{{- end }}
\end{tabularx}
{{- if ne $i 3}} \vfill {{- end -}}
{{- end -}}