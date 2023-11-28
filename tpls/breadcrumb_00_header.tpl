{\noindent\Large\renewcommand{\arraystretch}{\myNumArrayStretch}
{{ if $.Cfg.ClearTopLeftCorner -}}\kern 5mm{{- end }}{{- .Body.Breadcrumb -}}{{ if $.Cfg.ClearTopRightCorner -}}\kern 5mm{{- end }}
\hfill%
{{ .Body.Extra.Table false -}}
}
\myLineThick\medskip
