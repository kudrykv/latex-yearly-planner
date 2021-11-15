{{ if $.Cfg.Dotted -}} \vskip-.5\myLenLineHeightButLine\myMash{36}{30} {{- else -}}
\vbox to \dimexpr\textheight-\pagetotal-\myLenLineHeightButLine\relax {%
  \leaders\hbox to \linewidth{\textcolor{\myColorGray}{\rule{0pt}{\myLenLineHeightButLine}\hrulefill}}\vfil
}
{{end}}