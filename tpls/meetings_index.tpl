\begin{tabularx}{\linewidth}{@{}p{.5cm}@{}|@{}X}
  \arrayrulecolor{\myColorGray}
  {{range $number := .Body}}
    \hyperlink{M\# {{- $number -}} }{ {{- $number -}} }\myLineHeightButLine& \\ \hline
  {{end}}
\end{tabularx}
\par\pagebreak
