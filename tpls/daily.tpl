{{range $i, $page := .Pages -}}
{{- template "header.tpl" dict "Cfg" $.Cfg "Header" $page.Header -}}
{{- $today := $page.Body -}}

\parbox[t]{\myLenTwoCol}{%
    \myUnderline{To Do\textcolor{white}{g}\hfill{}All todos}
    \Repeat{\myNumDailyTodos}{\myTodoLineGray}
    \vskip\dimexpr7mm-4pt
    \myUnderline{Notes $\vert$ More\hfill{}Reflect\hfill{}All notes}
    \Repeat{\myNumDailyNotes}{\myLineGrayVskipTop}
}%
\hspace{\myLenTwoColSep}%
\parbox[t]{\myLenTwoCol}{%
    \myUnderline{Schedule\textcolor{white}{g}}\vskip-\myLenLineThicknessDefault
    \foreach \x in {\myNumDailyBottomHour,...,\myNumDailyTopHour}
        {\myLineGray\myLineHeightButLine\x\myLineLightGray\vskip\myLenLineHeightButLine}
    \myLineGrayVskipBottom\myLineLightGray
}
\par

{{- if ne $i (dec (len $.Pages)) -}}
  \pagebreak
{{end}}
{{end}}