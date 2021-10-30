{%
\renewcommand{\arraystretch}{\myNumArrayStretch}%
\setlength{\tabcolsep}{\myLenTabColSep}%
%
\begin{tabularx}{\linewidth}{Y|*{7}{Y}}
  \multicolumn{8}{c}{ {{- .Month.Link -}} } \\ \hline
  {{.Month.WeekHeader}} \\ \hline
  {{- range $i, $week := .Month.Weeks }}
  {{$week.WeekNumber}} &
    {{- range $j, $day := $week.Days }}
      {{- $day.Day -}} {{ if eq $j 6 }} \\ {{- else }} & {{ end -}}
    {{ end -}}
  {{ end }}
\end{tabularx}
}