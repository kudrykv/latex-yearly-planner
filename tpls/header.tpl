{%
\noindent\Large%
\renewcommand{\arraystretch}{\myNumArrayStretch}%
{{if gt (len .Body.Left) 0 -}}
\begin{tabular}{ {{- .Body.Left.ColSetup true -}} }
{{.Body.Left.Row}}
\end{tabular}
{{- end -}}
\hfill%
{{if gt (len .Body.Right) 0 -}}
\begin{tabular}{ {{- .Body.Right.ColSetup false -}} }
{{.Body.Right.Row}}
\end{tabular}
{{- end -}}
}
\myLineThick\medskip
