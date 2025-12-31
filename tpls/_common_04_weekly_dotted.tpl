{{- $days := .Body.Week.Days -}}
{{- $day1 := index $days 0 -}}
{{- $day2 := index $days 1 -}}
{{- $day3 := index $days 2 -}}
{{- $day4 := index $days 3 -}}
{{- $day5 := index $days 4 -}}
{{- $day6 := index $days 5 -}}
{{- $day7 := index $days 6 -}}

\hspace{5mm}\parbox{\dimexpr\textwidth-5mm}{\myUnderline{ {{- $day1.WeekLink -}} }}
\hspace{5mm}\myMash[\myDummyQ]{3}{\myNumDotWidthFull}
\vskip 2mm

\hspace{5mm}\parbox{\dimexpr\textwidth-5mm}{\myUnderline{ {{- $day2.WeekLink -}} }}
\hspace{5mm}\myMash[\myDummyQ]{3}{\myNumDotWidthFull}
\vskip 2mm

\hspace{5mm}\parbox{\dimexpr\textwidth-5mm}{\myUnderline{ {{- $day3.WeekLink -}} }}
\hspace{5mm}\myMash[\myDummyQ]{3}{\myNumDotWidthFull}
\vskip 2mm

\hspace{5mm}\parbox{\dimexpr\textwidth-5mm}{\myUnderline{ {{- $day4.WeekLink -}} }}
\hspace{5mm}\myMash[\myDummyQ]{3}{\myNumDotWidthFull}
\vskip 2mm

\hspace{5mm}\parbox{\dimexpr\textwidth-5mm}{\myUnderline{ {{- $day5.WeekLink -}} }}
\hspace{5mm}\myMash[\myDummyQ]{3}{\myNumDotWidthFull}
\vskip 2mm

\hspace{5mm}\parbox{\dimexpr\textwidth-5mm}{\myUnderline{ {{- $day6.WeekLink -}} }}
\hspace{5mm}\myMash[\myDummyQ]{3}{\myNumDotWidthFull}
\vskip 2mm

\hspace{5mm}\parbox{\dimexpr\textwidth-5mm}{\myUnderline{ {{- $day7.WeekLink -}} }}
\hspace{5mm}\myMash[\myDummyQ]{3}{\myNumDotWidthFull}
