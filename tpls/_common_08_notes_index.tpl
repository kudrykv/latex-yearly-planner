\begin{tabularx}{\linewidth}{l|X}
  \arrayrulecolor{\myColorGray}
{{ range $note := .Body.Notes }}
  {{ $note.HyperLink }} & \myLineHeightButLine{} \\ \hline
{{ end }}
\end{tabularx}
