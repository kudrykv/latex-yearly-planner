{\noindent\Large\renewcommand{\arraystretch}{\myNumArrayStretch}
{{- .Body.Breadcrumb -}}
\hfill
\hbox{ 
    {{ if .Cfg.ShowKeyOnYearPage }}
    \mbox{\small key: journaled}
    {{ else }}
    \hspace{0pt} % Placeholder for spacing
    {{ end }}
}
\hfill%
{{ .Body.Extra.Table false -}}
}
\myLineThick\medskip
{{ template "_common_01_annual.tpl" dict "Cfg" .Cfg "Body" .Body }}
