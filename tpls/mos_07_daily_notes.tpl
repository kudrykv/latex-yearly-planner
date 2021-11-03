{{ template "mos_00_header.tpl" dict "Cfg" .Cfg "Body" .Body }}

\vbox to \dimexpr\textheight-\pagetotal-\myLenLineHeightButLine\relax {%
    \leaders\hbox to \linewidth{\textcolor{\myColorGray}{\rule{0pt}{\myLenLineHeightButLine}\hrulefill}}\vfil
}%
\par\pagebreak
