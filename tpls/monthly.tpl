\begin{tabularx}{\textwidth}{@{}
  {{- if $.Cfg.Pages.WeeklyEnabled -}}
    l!{\vrule width \myLenLineThicknessThick}
  {{- else -}} | {{- end -}}
  *{7}{@{}X@{}|}}
\noalign{\hrule height \myLenLineThicknessThick}
{{.Body.WeekHeaderFull $.Cfg.Pages.WeeklyEnabled}} \\ \noalign{\hrule height \myLenLineThicknessThick}

{{- range $row := .Body.Matrix}}
  {{if $.Cfg.Pages.WeeklyEnabled -}}
    \hyperlink{
      {{- if and (eq ($.Body.MonthName.String) "January") (gt $row.WeekNumber 50) -}}
        {{- $row.RefText "fw" -}}
      {{- else -}}
        {{- $row.RefText "" -}}
      {{- end -}}
    }{\rotatebox[origin=tr]{90}{\makebox[\myLenMonthlyCellHeight][c]{ {{- $row.Text true -}} }}} &
  {{end -}}

  {{range $j, $item := . -}}
    {{- if not $item.IsZero -}}
      \hyperlink{ {{- $item.RefText -}} }{\begin{tabular}{@{}p{5mm}@{}|}\hfil{}{{- $item.Day -}}\\ \hline\end{tabular}}
    {{- end -}}

    {{- if ne $j (dec (len $row)) }} & {{else}} \rotatebox[origin=tr]{90}{\makebox[\myLenMonthlyCellHeight][c]{}} \\ \hline {{end -}}
  {{- end -}}
{{end}}
\end{tabularx}
\medskip

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

\pagebreak
