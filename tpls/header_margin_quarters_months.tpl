{{if is .Body.Year}}
\begin{tabular}{@{}l}
  \resizebox{!}{\myLenHeaderResizeBox}{\hypertarget{ {{- .Body.Year -}} }{ {{- .Body.Year -}} \myDummyQ}}
\end{tabular}
{{- end -}}
{{if is .Body.Quarter}}
\begin{tabular}{@{}l}
  \resizebox{!}{\myLenHeaderResizeBox}{\hypertarget{Q {{- .Body.Quarter -}} }{Q {{- .Body.Quarter -}} }}
\end{tabular}
{{- end -}}
{{if is .Body.Month}}
\begin{tabular}{@{}l}
  \resizebox{!}{\myLenHeaderResizeBox}{\hypertarget{ {{- .Body.Month.Month -}} }{ {{- .Body.Month.Month -}} \myDummyQ}}
\end{tabular}
{{- end -}}
{{if is .Body.Week}}
\begin{tabular}{@{}l}
  \resizebox{!}{\myLenHeaderResizeBox}{\hypertarget{ {{- .Body.Week.RefText .Body.WeekPrefix -}} }{Week {{.Body.Week.WeekNumber -}} \myDummyQ}}
\end{tabular}
{{- end -}}
{{ if is .Body.Today}}
\hypertarget{ {{- .Body.Today.RefText -}} }{}%
\begin{tabular}{@{}l|l}
  \multirow{2}{*}{\resizebox{!}{\myLenHeaderResizeBox}{ {{- .Body.Today.Day -}} }} & \textbf{ {{- .Body.Today.Weekday -}} } \\
  & {{- .Body.Today.Month -}}
\end{tabular}
{{- end -}}
{{if is .Body.TodayNote}}
\hypertarget{Notes {{- .Body.TodayNote.RefText -}} }{}%
\hyperlink{ {{- .Body.TodayNote.RefText -}} }{%
  \begin{tabular}{@{}l|l}
    \multirow{2}{*}{\resizebox{!}{\myLenHeaderResizeBox}{ {{- .Body.TodayNote.Day -}} }} & \textbf{ {{- .Body.TodayNote.Weekday -}} } \\
    & {{- .Body.TodayNote.Month -}}
  \end{tabular}%
}
{{- end -}}
{{if is .Body.TodayReflect}}
\hypertarget{Reflect {{- .Body.TodayReflect.RefText -}} }{}%
\hyperlink{ {{- .Body.TodayReflect.RefText -}} }{%
  \begin{tabular}{@{}l|l}
    \multirow{2}{*}{\resizebox{!}{\myLenHeaderResizeBox}{ {{- .Body.TodayReflect.Day -}} }} & \textbf{ {{- .Body.TodayReflect.Weekday -}} } \\
    & {{- .Body.TodayReflect.Month -}}
  \end{tabular}%
}
{{- end -}}
{{if is .Body.Notes}}
\begin{tabular}{@{}l}
  \hypertarget{ {{- .Body.Notes -}} }{}\resizebox{!}{\myLenHeaderResizeBox}{ {{- .Body.Notes -}} \myDummyQ}
\end{tabular}
{{- end -}}
{{if is .Body.Todos}}
\begin{tabular}{@{}l}
  \hypertarget{ {{- .Body.Todos -}} }{}\resizebox{!}{\myLenHeaderResizeBox}{ {{- .Body.Todos -}} \myDummyQ}
\end{tabular}
{{- end -}}
{{if is .Body.Meetings}}
\begin{tabular}{@{}l}
  \hypertarget{ {{- .Body.Meetings -}} }{}\resizebox{!}{\myLenHeaderResizeBox}{ {{- .Body.Meetings -}} \myDummyQ}
\end{tabular}
{{- end -}}
\hfill%
{\renewcommand{\arraystretch}{\myNumArrayStretch}%
  \begin{tabular}{*{ {{- len .Body.Cells -}} }{c|}@{}}
  {{range $i, $cell := .Body.Cells}}
    {{$cell.Display}} {{ if not (eq (incr $i) (len $.Body.Cells)) }} &{{end}}
  {{end}}
  \end{tabular}}%
\medskip
\myLineThick
\marginnote{%
  \rotatebox[origin=tr]{90}{%
    \renewcommand{\arraystretch}{2}%
    \begin{tabularx}{14.35cm}{*{11}{Y|}Y}
    {{range $i, $month := .Body.Months -}}
    {{$month.Display}} {{if ne $i 11}}
      & {{else}} \\ \hline {{end}}
    {{end}}
    \end{tabularx}%
    \quad
    \begin{tabularx}{4cm}{*{3}{Y|}Y}
    {{range $i, $quarter := .Body.Quarters -}}
    {{$quarter.Display}} {{if ne $i 3}}
      & {{else}} \\ \hline {{end}}
    {{end}}
    \end{tabularx}%
  }%
}%
\medskip