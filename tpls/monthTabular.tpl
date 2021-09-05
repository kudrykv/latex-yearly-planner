{%
\renewcommand{\arraystretch}{\myNumArrayStretch}%
\setlength{\tabcolsep}{\myLenTabColSep}%
\begin{tabular}[t]{ {{- .Month.WeekLayout .Cfg.Blocks.Weekly.Enabled -}} }
\multicolumn%
  { {{- .Month.WeekHeaderLen .Cfg.Blocks.Weekly.Enabled -}} }%
  {c}%
  { {{- template "slink.tpl" .Month.MonthName -}} } \\ \hline
{{.Month.WeekHeader .Cfg.Blocks.Weekly.Enabled}} \\ \hline
{{- range $row := .Month.Matrix}}
  {{if $.Cfg.Blocks.Weekly.Enabled -}}
    {{if and (eq ($.Month.MonthName.String) "January") (gt $row.WeekNumber 50)}}
      {{- $row.LinkWeek "fw" false}} &
    {{- else -}}
      {{- $row.LinkWeek "" false}} &
    {{- end -}}
  {{end -}}
  {{range $j, $item := .}}
    {{if not $item.IsZero}} {{ $item.Link }} {{end}}
    {{- if ne $j (dec (len $row)) }} & {{else}} \\ {{end -}}
  {{- end -}}
{{end}}
\end{tabular}}