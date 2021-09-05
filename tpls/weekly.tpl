{{range $i, $page := .Pages -}}
{{- template "header.tpl" dict "Cfg" $.Cfg "Header" $page.Header -}}
{{- $week := .Body -}}
{{- $day1 := index $week 0 -}}
{{- $day2 := index $week 1 -}}
{{- $day3 := index $week 2 -}}
{{- $day4 := index $week 3 -}}
{{- $day5 := index $week 4 -}}
{{- $day6 := index $week 5 -}}
{{- $day7 := index $week 6 -}}

\parbox{\myLenTriCol}{%
    \myUnderline{ {{- $day1.Day}} {{$day1.Weekday -}} }\Repeat{\myNumWeeklyLines}{\myLineGrayVskipTop}%
}%
\hspace{\myLenTriColSep}%
\parbox{\myLenTriCol}{%
    \myUnderline{ {{- $day2.Day}} {{$day2.Weekday -}} }\Repeat{\myNumWeeklyLines}{\myLineGrayVskipTop}%
}%
\hspace{\myLenTriColSep}%
\parbox{\myLenTriCol}{%
    \myUnderline{ {{- $day3.Day}} {{$day3.Weekday -}} }\Repeat{\myNumWeeklyLines}{\myLineGrayVskipTop}%
}
\vfill
\parbox{\myLenTriCol}{%
    \myUnderline{ {{- $day4.Day}} {{$day4.Weekday -}} }\Repeat{\myNumWeeklyLines}{\myLineGrayVskipTop}%
}%
\hspace{\myLenTriColSep}%
\parbox{\myLenTriCol}{%
    \myUnderline{ {{- $day5.Day}} {{$day5.Weekday -}} }\Repeat{\myNumWeeklyLines}{\myLineGrayVskipTop}%
}%
\hspace{\myLenTriColSep}%
\parbox{\myLenTriCol}{%
    \myUnderline{ {{- $day6.Day}} {{$day6.Weekday -}} }\Repeat{\myNumWeeklyLines}{\myLineGrayVskipTop}%
}
\vfill
\parbox{\myLenTriCol}{%
    \myUnderline{ {{- $day7.Day}} {{$day7.Weekday -}} }\Repeat{\myNumWeeklyLines}{\myLineGrayVskipTop}%
}%
\hspace{\myLenTriColSep}%
\parbox{\dimexpr2\myLenTriCol+\myLenTriColSep}{%
    \myUnderline{Notes\textcolor{white}{g}}\Repeat{\myNumWeeklyLines}{\myLineGrayVskipTop}%
}

{{- if ne $i (dec (len $.Pages)) -}}
  \pagebreak
{{end}}
{{end}}