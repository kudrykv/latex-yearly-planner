{{ template "mos_00_header.tpl" dict "Cfg" .Cfg "Body" .Body }}

{{- $today := .Body.Day -}}

\begin{minipage}[t]{\myLenTriCol}
{{template "schedule.tpl" dict "Cfg" .Cfg "Day" .Body.Day}}
  \vspace{\dimexpr4mm+.3pt}

{{- template "monthTabularV2.tpl" dict "Month" .Body.Month "Today" $today -}}
\end{minipage}%
\hspace{\myLenTriColSep}%
\begin{minipage}[t]{\dimexpr2\myLenTriCol+\myLenTriColSep}
  \myUnderline{Top priorities\textcolor{white}{g}}
  \Repeat{\myNumDailyTodos}{\myTodoLineGray}
  \vskip\dimexpr7mm-1.4pt
  \myUnderline{Notes\hfill {{- $today.LinkLeaf "More" "More" -}} }
  \Repeat{\myNumDailyNotes}{\myLineGrayVskipTop}
  \vskip\dimexpr7mm-1.2pt
  \myUnderline{Personal\hfill{{ $today.LinkLeaf "Reflect" "Reflect" }}}
  \Repeat{\myNumDailyPersonal}{\myLineGrayVskipTop}
\end{minipage}
\par\pagebreak
