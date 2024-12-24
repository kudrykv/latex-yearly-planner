{{- if $.Cfg.Dotted -}}
  \vskip-.5\myLenLineHeightButLine\myMash{\myNumDotHeightFull}{\myNumDotWidthFull}
{{- else if $.Cfg.Blank -}}
  \vskip\textheight minus \pagetotal
{{- else if $.Cfg.Grid -}}
  \vskip-.5\myLenLineHeightButLine\myMash{\myNumDotHeightFull}{\myNumDotWidthFull}
{{- else -}}
  \vbox to \dimexpr\textheight-\pagetotal-\myLenLineHeightButLine\relax {%
    \leaders\hbox to \linewidth{\textcolor{\myColorGray}{\rule{0pt}{\myLenLineHeightButLine}\hrulefill}}\vfil
  }
{{- end}}