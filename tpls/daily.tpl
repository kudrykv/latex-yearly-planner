{{- $today := .Body.Day -}}

\parbox[t]{\myLenTwoCol}{%
  \myUnderline{To Do\textcolor{white}{g}\hfill{}\hyperlink{Todos Index}{All todos}}
  \Repeat{\myNumDailyTodos}{\myTodoLineGray}
  \vskip\dimexpr7mm-4pt
  \myUnderline{Notes $\vert$ \hyperlink{notes {{- $today.RefText -}} }{More}\hfill{}\hyperlink{reflect {{- $today.RefText -}} }{Reflect}\hfill{}\hyperlink{Notes Index}{All notes}}
  \Repeat{\myNumDailyNotes}{\myLineGrayVskipTop}
}%
\hspace{\myLenTwoColSep}%
\parbox[t]{\myLenTwoCol}{%
  {{template "hours.tpl" dict "Cfg" .Cfg "Hours" .Body.Hours "AddLastHalfHour" true}}
}
\par

\pagebreak
