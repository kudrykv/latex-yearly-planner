{{range .Qrtr}}
\begin{tabularx}{\linewidth}{@{}*{3}{X}@{}}
{{range $i, $element := .}}
  {{template "monthTabular.tpl" dict "Cfg" $.Cfg "Month" $element}}
  {{- if or (eq $i 2) (eq $i 5) (eq $i 8) (eq $i 11) }} \\ {{else}} & {{end}}
{{end}}
\end{tabularx}
{{end}}