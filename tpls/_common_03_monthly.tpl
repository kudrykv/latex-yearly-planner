{{- template "monthTabularV2.tpl" dict "Month" .Body.Month "Large" true -}}
\medskip

{{ if $.Cfg.Dotted -}}
\myUnderline{Notes}
% TODO: This 40 needs to be parameterized based on page length or something
\vbox to 0pt{\myMash[\myMonthlySpring]{40}{\myNumDotWidthFull}}
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
