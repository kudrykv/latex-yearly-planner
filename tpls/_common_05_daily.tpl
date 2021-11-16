{{- $today := .Body.Day -}}

\begin{minipage}[t]{\myLenTriCol}
{{template "schedule.tpl" dict "Cfg" .Cfg "Day" .Body.Day}}
  \vspace{\dimexpr4mm+.3pt}

{{- if .Cfg.CalAfterSchedule -}}
{{- template "monthTabularV2.tpl" dict "Month" .Body.Month "Today" $today -}}
{{- end -}}
\end{minipage}%
\hspace{\myLenTriColSep}%
\begin{minipage}[t]{\dimexpr2\myLenTriCol+\myLenTriColSep}
  \myUnderline{Top priorities\myDummyQ}
  \Repeat{\myNumDailyTodos}{\myTodoLineGray}
  \vskip\dimexpr7mm-1.4pt
  \myUnderline{Notes\hfill{}{{ $today.LinkLeaf "More" "More" }}\hfill{}{{ $today.LinkLeaf "Reflect" "Reflect" }}}
  \myMash[\myDailySpring]{\myNumDailyNotes}{\myNumDotWidthTwoThirds}
\end{minipage}
\par\pagebreak
