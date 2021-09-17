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
\begin{tabular}{ {{- .Body.Right.ColSetup false -}}{{if .Cfg.ClearTopRightCorner}}@{\hspace{\tabcolsep}}|c@{}{{end}} }
{{.Body.Right.Row}}{{if .Cfg.ClearTopRightCorner}}& \hspace{7mm}{{end}}
\end{tabular}
{{- end -}}
}
\myLineThick\medskip
