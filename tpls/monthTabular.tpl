{%
\renewcommand{\arraystretch}{\myNumArrayStretch}%
\setlength{\tabcolsep}{\myLenTabColSep}%
\begin{tabular}[t]{ {{- .Month.WeekLayout .Cfg.Blocks.Weekly.Enabled -}} }
\multicolumn{ {{- .Month.WeekHeaderLen .Cfg.Blocks.Weekly.Enabled -}} }{c}{ {{- .Month.MonthName -}} } \\ \hline
{{.Month.WeekHeader .Cfg.Blocks.Weekly.Enabled}} \\ \hline
{{- range $row := .Month.Matrix .Cfg.Blocks.Weekly.Enabled true}}
  {{range $j, $item := . -}}
    {{$item}}
    {{- if ne $j (dec (len $row)) }} & {{else}} \\ {{end -}}
  {{- end -}}
{{end}}
\end{tabular}}