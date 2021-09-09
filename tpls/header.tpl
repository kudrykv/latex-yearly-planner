{%
\noindent\Large%
\renewcommand{\arraystretch}{\myNumArrayStretch}%
{{if gt (len .Header.Left) 0 -}}
\begin{tabular}{ {{- .Header.Left.ColSetup true -}} }
{{.Header.Left.Row}}
\end{tabular}
{{- end -}}
\hfill%
{{if gt (len .Header.Right) 0 -}}
\begin{tabular}{ {{- .Header.Right.ColSetup false -}} }
{{.Header.Right.Row}}
\end{tabular}
{{- end -}}
}
\myLineThick\medskip
