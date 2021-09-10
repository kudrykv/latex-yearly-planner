{{range $i, $qrtr := .Quarters}}
  \begin{tabularx}{\linewidth}{@{}*{3}{X}@{}}
  {{- range $j, $month := $qrtr}}
    {{- template "monthTabular.tpl" dict "Cfg" $.Cfg "Month" $month}}
    {{- if ne $j 2 }} & {{end}}
  {{- end }}
  \end{tabularx}
  {{- if ne $i 3}} \vfill {{- end -}}
{{- end -}}