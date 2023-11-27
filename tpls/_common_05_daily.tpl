{{- $today := .Body.Day -}}
\colorbox{white}{%
\begin{minipage}[t]{\dimexpr2\myLenTriCol+\myLenTriColSep}
  \myUnderline{Todo\myDummyQ}
  \Repeat{\myNumDailyTodos}{\myTodoLineGray}
  \vskip\dimexpr5.4mm
  \myUnderline{Notes \textcolor{\myColorGray}{$\vert$ {{ $today.LinkLeaf "More" "More" }}\hfill{}{{ $today.LinkLeaf "Reflect" "Reflect" }}\hfill{}\hyperlink{Notes Index}{Notes} $\vert$ \hyperlink{Meetings Index}{Meetings}}}
  \myMash[\myDailySpring]{\myNumDailyNotes}{\myNumDotWidthTwoThirds}
\end{minipage}%
\hspace{\myLenTriColSep}%
\begin{minipage}[t]{\myLenTriCol}
{{template "schedule.tpl" dict "Cfg" .Cfg "Day" .Body.Day}}
  \vspace{\dimexpr4mm+.3pt}

{{- if .Cfg.CalAfterSchedule -}}
{{- template "monthTabularV2.tpl" dict "Month" .Body.Month "Today" $today -}}
{{- end -}}
\end{minipage}%
\par\pagebreak
