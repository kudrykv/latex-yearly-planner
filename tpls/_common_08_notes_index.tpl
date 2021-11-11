\begin{tabularx}{\linewidth}{l|X}
  \arrayrulecolor{\myColorGray}
{{ range $note := .Body.Notes }}
  \hyperlink{Note {{ $note.Number }}}{ {{- $note.Number -}} } & \myLineHeightButLine{} \\ \hline
{{ end }}
\end{tabularx}
