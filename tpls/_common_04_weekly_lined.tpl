{{- $days := .Body.Week.Days -}}
{{- $day1 := index $days 0 -}}
{{- $day2 := index $days 1 -}}
{{- $day3 := index $days 2 -}}
{{- $day4 := index $days 3 -}}
{{- $day5 := index $days 4 -}}
{{- $day6 := index $days 5 -}}
{{- $day7 := index $days 6 -}}

\hspace{5mm}\parbox{\dimexpr\textwidth-5mm}{%
  \myUnderline{ {{- $day1.WeekLink -}} }\Repeat{3}{\myLineGrayVskipTop}%
}
\vskip 2mm

\hspace{5mm}\parbox{\dimexpr\textwidth-5mm}{%
  \myUnderline{ {{- $day2.WeekLink -}} }\Repeat{3}{\myLineGrayVskipTop}%
}
\vskip 2mm

\hspace{5mm}\parbox{\dimexpr\textwidth-5mm}{%
  \myUnderline{ {{- $day3.WeekLink -}} }\Repeat{3}{\myLineGrayVskipTop}%
}
\vskip 2mm

\hspace{5mm}\parbox{\dimexpr\textwidth-5mm}{%
  \myUnderline{ {{- $day4.WeekLink -}} }\Repeat{3}{\myLineGrayVskipTop}%
}
\vskip 2mm

\hspace{5mm}\parbox{\dimexpr\textwidth-5mm}{%
  \myUnderline{ {{- $day5.WeekLink -}} }\Repeat{3}{\myLineGrayVskipTop}%
}
\vskip 2mm

\hspace{5mm}\parbox{\dimexpr\textwidth-5mm}{%
  \myUnderline{ {{- $day6.WeekLink -}} }\Repeat{3}{\myLineGrayVskipTop}%
}
\vskip 2mm

\hspace{5mm}\parbox{\dimexpr\textwidth-5mm}{%
  \myUnderline{ {{- $day7.WeekLink -}} }\Repeat{3}{\myLineGrayVskipTop}%
}
