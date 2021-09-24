{%
\renewcommand{\arraystretch}{\myNumArrayStretch}%
\setlength{\tabcolsep}{\myLenTabColSep}%

{{- if is .UseTabularx}}
\begin{tabularx}{\linewidth}{ {{- if .Cfg.Pages.WeeklyEnabled -}} Y| {{- end -}} *{7}{Y}}
{{- else}}
\begin{tabular}[t]{ {{- if .Cfg.Pages.WeeklyEnabled -}} c| {{- end -}} *{7}{c}}
{{- end}}
{{- if not (is .HideName) -}}
\multicolumn%
  { {{- .Month.WeekHeaderLen .Cfg.Pages.WeeklyEnabled -}} }%
  {c}%
  { {{- template "slink.tpl" .Month.MonthName -}} } \\ \hline
{{- end}}
{{.Month.WeekHeader .Cfg.Pages.WeeklyEnabled}} \\ \hline
{{ .Month.MatrixTexed .Cfg.Pages.WeeklyEnabled false false .Today -}}
{{if is .UseTabularx}}
\end{tabularx}
{{- else -}}
\end{tabular}
{{- end -}}
}