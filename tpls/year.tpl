{{template "header.tpl" .}}
\begin{tabularx}{\linewidth}{@{}*{3}{X}@{}}
{{range $i, $qrtr := .Body}}
  {{- range $j, $month := $qrtr}}
    {{- template "monthTabular.tpl" dict "Cfg" $.Cfg "Month" $month}}
    {{- if ne $j 2 }} & {{end}}
  {{- end }}
  {{- if ne $i 3}} \\ {{- end -}}
{{- end -}}
\end{tabularx}
