{{- template "monthTabularV2.tpl" dict "Month" .Body.Month "Large" true -}}
\medskip

{{ if or $.Cfg.Dotted $.Cfg.Blank $.Cfg.Grid -}}
\myUnderline{Notes}
\vbox to 0pt{\myMash[\myMonthlySpring]{20}{\myNumDotWidthFull}}
{{- else -}}
\parbox{\myLenTwoCol}{
  \myUnderline{Notes}
  \vbox to \dimexpr\textheight-\pagetotal-\myLenLineHeightButLine\relax {%
    \leaders\hbox to \linewidth{\textcolor{\myColorGray}{\rule{0pt}{\myLenLineHeightButLine}\hrulefill}}\vfil
  }%
}%
\hspace{\myLenTwoColSep}%
\parbox{\myLenTwoCol}{
  \myUnderline{Notes}
  \vbox to \dimexpr\textheight-\pagetotal-\myLenLineHeightButLine\relax {%
    \leaders\hbox to \linewidth{\textcolor{\myColorGray}{\rule{0pt}{\myLenLineHeightButLine}\hrulefill}}\vfil
  }%
}
{{- end}}
