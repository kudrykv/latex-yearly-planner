{{ template "header_v2.tpl" dict "Cfg" .Cfg "Body" .Body }}

\begin{tabularx}{\linewidth}{l|X}
{{ range $note := .Body.Notes }}
{{ $note.Number }} & \myLineHeightButLine{} \\ \hline
{{ end }}
\end{tabularx}

\par\pagebreak
