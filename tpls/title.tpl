\hspace{0pt}\vfil
{{- if ne .Cfg.Title "" }}
    {{- if .Cfg.ClearTopRightCorner }}
        \hfill\resizebox{.5\linewidth}{!}{ {{- .Cfg.Title | escapeLatex -}} }\hspace{5mm}
    {{- else }}
        \hfill\resizebox{.5\linewidth}{!}{ {{- .Cfg.Title | escapeLatex -}} }
    {{- end }}
    \\
{{- end }}
\vfill
\hfill\resizebox{.7\linewidth}{!}{ {{- .Cfg.Year -}} }\hspace{0mm}
\vspace{10pt}
\pagebreak