{{- template "header.tpl" dict "Cfg" $.Cfg "Header" .Header -}}

\vbox to \dimexpr\textheight-\pagetotal-\myLenLineHeightButLine\relax {%
    \leaders\hbox to \linewidth{\textcolor{\myColorGray}{\rule{0pt}{\myLenLineHeightButLine}\hrulefill}}\vfil
}%
\par

\pagebreak
