{{- template "header.tpl" dict "Cfg" $.Cfg "Header" .Header -}}
{{- $today := .Body -}}

\parbox[t]{\myLenTwoCol}{%
    \myUnderline{To Do\textcolor{white}{g}\hfill{}All todos}
    \Repeat{\myNumDailyTodos}{\myTodoLineGray}
    \vskip\dimexpr7mm-4pt
    \myUnderline{Notes $\vert$ \hyperlink{notes {{- $today.RefText -}} }{More}\hfill{}\hyperlink{reflect {{- $today.RefText -}} }{Reflect}\hfill{}All notes}
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

\pagebreak
