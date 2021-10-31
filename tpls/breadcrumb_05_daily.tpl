{{ template "header_v2.tpl" dict "Cfg" .Cfg "Body" .Body }}

{{- $today := .Body.Day -}}

\parbox[t]{\myLenTwoCol}{%
  \myUnderline{To Do\textcolor{white}{g}\hfill{}\hyperlink{Todos Index}{All todos}}
  \Repeat{\myNumDailyTodos}{\myTodoLineGray}
  \vskip\dimexpr7mm-4pt
  \myUnderline{Notes $\vert$ More\hfill{}Reflect\hfill{}\hyperlink{Notes Index}{All notes}}
  \Repeat{\myNumDailyNotes}{\myLineGrayVskipTop}
}%
\hspace{\myLenTwoColSep}%
\parbox[t]{\myLenTwoCol}{%
  {{template "schedule.tpl" dict "Cfg" .Cfg "Day" .Body.Day "AddLastHalfHour" true}}
}
\par

\pagebreak