{{range $i, $page := .Pages -}}
{{- template "header.tpl" dict "Cfg" $.Cfg "Header" $page.Header -}}

\begin{tabularx}{\textwidth}{@{}
  {{- if $.Cfg.Blocks.Weekly.Enabled -}}
    l!{\vrule width \myLenLineThicknessThick}
  {{- else -}} | {{- end -}}
  *{7}{@{}X@{}|}}
\noalign{\hrule height \myLenLineThicknessThick}
{{$page.Body.WeekHeaderFull $.Cfg.Blocks.Weekly.Enabled}} \\ \noalign{\hrule height \myLenLineThicknessThick}

\end{tabularx}
\medskip

\parbox{\myLenTwoCol}{
  \myUnderline{Notes}
  \vbox to \dimexpr\textheight-\pagetotal-\myLenLineHeightButLine\relax {%
    \leaders\hbox to \linewidth{\textcolor{\myColorGray}{\rule{0pt}{\myLenLineHeightButLine}\hrulefill}}\vfil
  }%
}
\hspace{\myLenTwoColSep}
\parbox{\myLenTwoCol}{
    \myUnderline{Notes}
    \vbox to \dimexpr\textheight-\pagetotal-\myLenLineHeightButLine\relax {%
        \leaders\hbox to \linewidth{\textcolor{\myColorGray}{\rule{0pt}{\myLenLineHeightButLine}\hrulefill}}\vfil
    }%
}

{{- if ne $i (len $.Pages)}} \pagebreak {{end}}
{{end}}