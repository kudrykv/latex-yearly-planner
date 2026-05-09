{{- $days := .Body.Week.Days -}}
{{- $day1 := index $days 0 -}}
{{- $day2 := index $days 1 -}}
{{- $day3 := index $days 2 -}}
{{- $day4 := index $days 3 -}}
{{- $day5 := index $days 4 -}}
{{- $day6 := index $days 5 -}}
{{- $day7 := index $days 6 -}}

\parbox{\myLenTriCol}{\myUnderline{ {{- $day1.WeekLink -}} }}%
\hspace{\myLenTriColSep}%
\parbox{\myLenTriCol}{\myUnderline{ {{- $day2.WeekLink -}} }}%
\hspace{\myLenTriColSep}%
\parbox{\myLenTriCol}{\myUnderline{ {{- $day3.WeekLink -}} }}
\myMash{\myNumWeeklyLines}{\myNumDotWidthFull}
\vfill

\parbox{\myLenTriCol}{\myUnderline{ {{- $day4.WeekLink -}} }}%
\hspace{\myLenTriColSep}%
\parbox{\myLenTriCol}{\myUnderline{ {{- $day5.WeekLink -}} }}%
\hspace{\myLenTriColSep}%
\parbox{\myLenTriCol}{\myUnderline{ {{- $day6.WeekLink -}} }}
\myMash{\myNumWeeklyLines}{\myNumDotWidthFull}
\vfill

\parbox{\myLenTriCol}{ \myUnderline{ {{- $day7.WeekLink -}} }}%
\hspace{\myLenTriColSep}%
\parbox{\dimexpr2\myLenTriCol+\myLenTriColSep}{\myUnderline{Notes\myDummyQ}}
\myMash{\myNumWeeklyLines}{\myNumDotWidthFull}