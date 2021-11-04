{{ template "mos_00_header.tpl" dict "Cfg" .Cfg "Body" .Body }}

\begin{tabularx}{\linewidth}{l|X}
{{ range $note := .Body.Notes }}
\hyperlink{Note {{ $note.Number }}}{ {{- $note.Number -}} } & \myLineHeightButLine{} \\ \hline
{{ end }}
\end{tabularx}

\par\pagebreak
