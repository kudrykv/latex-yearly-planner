{%
\renewcommand{\arraystretch}{\myNumArrayStretch}%
\setlength{\tabcolsep}{\myLenTabColSep}%
\begin{tabular}[t]{ {{- .Month.WeekLayout .Cfg.RenderBlocks.WeeklyEnabled -}} }
\multicolumn%
  { {{- .Month.WeekHeaderLen .Cfg.RenderBlocks.WeeklyEnabled -}} }%
  {c}%
  { {{- template "slink.tpl" .Month.MonthName -}} } \\ \hline
{{.Month.WeekHeader .Cfg.RenderBlocks.WeeklyEnabled}} \\ \hline
{{- range $row := .Month.Matrix}}
  {{if $.Cfg.RenderBlocks.WeeklyEnabled -}}
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