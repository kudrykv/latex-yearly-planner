\begin{tabularx}{\linewidth}{l|X}
{{ range $note := .Body.Notes }}
  \hyperlink{Note {{ $note.Number }}}{ {{- $note.Number -}} } & \myLineHeightButLine{} \\ \hline
{{ end }}
\end{tabularx}
