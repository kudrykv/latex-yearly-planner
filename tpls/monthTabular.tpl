{%
\renewcommand{\arraystretch}{\myNumArrayStretch}%
\setlength{\tabcolsep}{\myLenTabColSep}%

{{- if is .UseTabularx}}
\begin{tabularx}{\linewidth}{ {{- if .Cfg.RenderBlocks.WeeklyEnabled -}} Y| {{- end -}} *{7}{Y}}
{{- else}}
\begin{tabular}[t]{ {{- if .Cfg.RenderBlocks.WeeklyEnabled -}} c| {{- end -}} *{7}{c}}
{{- end}}
{{- if not (is .HideName) -}}
\multicolumn%
  { {{- .Month.WeekHeaderLen .Cfg.RenderBlocks.WeeklyEnabled -}} }%
  {c}%
  { {{- template "slink.tpl" .Month.MonthName -}} } \\ \hline
{{- end}}
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
{{- end}}
{{if is .UseTabularx}}
\end{tabularx}
{{- else -}}
\end{tabular}
{{- end -}}
}