{{ template "breadcrumb_00_header.tpl" dict "Cfg" .Cfg "Body" .Body }}

{{- $today := .Body.Day -}}

\parbox[t]{\myLenTriCol}{%
{{template "schedule.tpl" dict "Cfg" .Cfg "Day" .Body.Day "AddLastHalfHour" true}}
}%
\hspace{\myLenTriColSep}%
\parbox[t]{\dimexpr2\myLenTriCol+\myLenTriColSep}{%
  \myUnderline{To Do\myDummyQ}
  \Repeat{\myNumDailyTodos}{\myTodoLineGray}
  \vskip\dimexpr7mm-4pt
  \myUnderline{Notes $\vert$ {{ $today.LinkLeaf "More" "More" }}\hfill{}{{ $today.LinkLeaf "Reflect" "Reflect" }}\hfill{}\hyperlink{Notes Index}{All notes}}
  \myMash{\myNumDailyNotes}{\myNumDotWidthTwoThirds}
}

\pagebreak
