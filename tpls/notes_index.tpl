\begin{tabularx}{\textwidth}{|*{ {{- len .Body -}} }{@{}X@{}|}}
  \hline
  {{- range $row := .Body}}
    {{range $j, $item := $row -}}
      \hyperlink{Note {{$item -}} }{\begin{tabular}{@{}p{5mm}@{}|}\hfil{}{{- $item -}}\\ \hline\end{tabular}}
      \vspace{\myLenNotesIndexCellHeight}
      {{- if eq $j 9}} \\ \hline {{else}} & {{end}}
    {{- end -}}
  {{end}}
\end{tabularx}
\par\pagebreak
