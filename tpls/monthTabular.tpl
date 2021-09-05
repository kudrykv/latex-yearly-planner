{%
\renewcommand{\arraystretch}{\myNumArrayStretch}%
\setlength{\tabcolsep}{\myLenTabColSep}%
\begin{tabular}[t]{ {{- .Month.WeekLayout .Cfg.Blocks.Weekly.Enabled -}} }
\multicolumn{ {{- .Month.WeekHeaderLen .Cfg.Blocks.Weekly.Enabled -}} }{c}{ {{- .Month.MonthName -}} } \\ \hline
{{.Month.WeekHeader .Cfg.Blocks.Weekly.Enabled}} \\ \hline
{{- range $row := .Month.Matrix}}
  {{if $.Cfg.Blocks.Weekly.Enabled -}} {{$row.WeekNumber}} & {{end -}}
  {{range $j, $item := . -}}
    {{if not $item.IsZero}} {{$item.Day}} {{end}}
    {{- if ne $j (dec (len $row)) }} & {{else}} \\ {{end -}}
  {{- end -}}
{{end}}
\end{tabular}}