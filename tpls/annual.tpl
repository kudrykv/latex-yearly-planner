{{range .Pages}}
{{template "header.tpl" dict "Cfg" $.Cfg "Header" .Header}}
{{range $i, $qrtr := .Body}}
  \begin{tabularx}{\linewidth}{@{}*{3}{X}@{}}
  {{- range $j, $month := $qrtr}}
    {{- template "monthTabular.tpl" dict "Cfg" $.Cfg "Month" $month}}
    {{- if ne $j 2 }} & {{end}}
  {{- end }}
  \end{tabularx}
  {{- if ne $i 3}} \vfill {{- end -}}
{{- end -}}
{{end}}