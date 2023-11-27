\begin{tabularx}{\linewidth}{l|X}
  \arrayrulecolor{\myColorGray}
{{ range $note := .Body.Meetings }}
  {{ $note.HyperLink }} & \myLineHeightButLine{} \\ \hline
{{ end }}
\end{tabularx}
