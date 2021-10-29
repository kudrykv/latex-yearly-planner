{%
\noindent\Large\renewcommand{\arraystretch}{\myNumArrayStretch}%
{{if gt .Body.Breadcrumb.Length 0 -}}

\begin{tabular}{ {{- .Body.Breadcrumb.ColSetup true -}} }
  {{.Body.Breadcrumb.Row}}
\end{tabular}

{{- end -}}

\hfill%
{{if gt .Body.Extra.Length 0 -}}
\begin{tabular}{ {{- .Body.Extra.ColSetup false -}}{{if .Cfg.ClearTopRightCorner}}@{\hspace{\tabcolsep}}|c@{}{{end}} }
  {{.Body.Extra.Row}}{{if .Cfg.ClearTopRightCorner}}& \hspace{7mm}{{end}}
\end{tabular}
{{- end -}}
}
\myLineThick\medskip
