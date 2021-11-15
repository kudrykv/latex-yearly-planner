{{- $days := .Body.Week.Days -}}
{{- $day1 := index $days 0 -}}
{{- $day2 := index $days 1 -}}
{{- $day3 := index $days 2 -}}
{{- $day4 := index $days 3 -}}
{{- $day5 := index $days 4 -}}
{{- $day6 := index $days 5 -}}
{{- $day7 := index $days 6 -}}

\begin{minipage}[t][60mm]{\linewidth}
  \parbox{\myLenTriCol}{\myUnderline{ {{- $day1.WeekLink -}} }}%
  \hspace{\myLenTriColSep}%
  \parbox{\myLenTriCol}{\myUnderline{ {{- $day2.WeekLink -}} }}%
  \hspace{\myLenTriColSep}%
  \parbox{\myLenTriCol}{\myUnderline{ {{- $day3.WeekLink -}} }}
  \par\myMash{\myNumWeeklyLines}{30}
\end{minipage}

\begin{minipage}[t][60mm]{\linewidth}
  \parbox{\myLenTriCol}{\myUnderline{ {{- $day4.WeekLink -}} }}%
  \hspace{\myLenTriColSep}%
  \parbox{\myLenTriCol}{\myUnderline{ {{- $day5.WeekLink -}} }}%
  \hspace{\myLenTriColSep}%
  \parbox{\myLenTriCol}{\myUnderline{ {{- $day6.WeekLink -}} }}
  \par\myMash{\myNumWeeklyLines}{30}
\end{minipage}

\begin{minipage}[t][60mm]{\linewidth}
  \parbox{\myLenTriCol}{ \myUnderline{ {{- $day7.WeekLink -}} }}%
  \hspace{\myLenTriColSep}%
  \parbox{\dimexpr2\myLenTriCol+\myLenTriColSep}{\myUnderline{Notes\myDummyQ}}
  \par\myMash{\myNumWeeklyLines}{30}
\end{minipage}
