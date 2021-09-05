{{range $i, $page := .Pages -}}
{{- template "header.tpl" dict "Cfg" $.Cfg "Header" $page.Header -}}

\parbox[t]{\myLenTwoCol}{%
  \myUnderline{Goals{}\textcolor{white}{g}}
  \myLineHeightButLine\Repeat{\myNumDailyDiaryGoals}{\myLineGrayVskipBottom}\vspace{3pt}
  \myUnderline{Things I'm grateful for}
  \myLineHeightButLine\Repeat{\myNumDailyDiaryGrateful}{\myLineGrayVskipBottom}\vspace{3pt}
  \myUnderline{The best thing that happened today}
  \Repeat{\myNumDailyDiaryBest}{\myLineGrayVskipTop}
}%
\hspace{\myLenTwoColSep}%
\parbox[t]{\myLenTwoCol}{%
  \myUnderline{Daily log}
  \Repeat{\myNumDailyDiaryLog}{\myLineGrayVskipTop}
}
\par

{{- if ne $i (dec (len $.Pages)) -}}
  \pagebreak
{{end}}
{{end}}