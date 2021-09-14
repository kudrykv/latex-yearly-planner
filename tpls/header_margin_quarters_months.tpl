{{if is .Body.Year}}
\begin{tabular}{@{}l}
  \resizebox{!}{.6cm}{\hypertarget{ {{- .Body.Year -}} }{ {{- .Body.Year -}} }}
\end{tabular}
{{- end -}}
{{if is .Body.Quarter}}
\begin{tabular}{@{}l}
  \resizebox{!}{.6cm}{\hypertarget{Q {{- .Body.Quarter -}} }{Q {{- .Body.Quarter -}} }}
\end{tabular}
{{- end -}}
{{if is .Body.Month}}
\begin{tabular}{@{}l}
  \resizebox{!}{.6cm}{\hypertarget{ {{- .Body.Month.Month -}} }{ {{- .Body.Month.Month -}} }}
\end{tabular}
{{- end -}}
{{if is .Body.Week}}
\begin{tabular}{@{}l}
  \resizebox{!}{.6cm}{\hypertarget{ {{- .Body.Week.RefText .Body.WeekPrefix -}} }{Week {{.Body.Week.WeekNumber -}} }}
\end{tabular}
{{- end -}}
{{ if is .Body.Today}}
\hypertarget{ {{- .Body.Today.RefText -}} }{}%
\begin{tabular}{@{}l|l}
  \multirow{2}{*}{\resizebox{!}{.5cm}{ {{- .Body.Today.Day -}} }} & \textbf{ {{- .Body.Today.Weekday -}} } \\
  & {{- .Body.Today.Month -}}
\end{tabular}
{{- end -}}
{{if is .Body.TodayNote}}
\hypertarget{Notes {{- .Body.TodayNote.RefText -}} }{}%
\hyperlink{ {{- .Body.TodayNote.RefText -}} }{%
\begin{tabular}{@{}l|l}
  \multirow{2}{*}{\resizebox{!}{.5cm}{ {{- .Body.TodayNote.Day -}} }} & \textbf{ {{- .Body.TodayNote.Weekday -}} } \\
  & {{- .Body.TodayNote.Month -}}
\end{tabular}%
}
{{- end -}}
{{if is .Body.TodayReflect}}
\hypertarget{Reflect {{- .Body.TodayReflect.RefText -}} }{}%
\hyperlink{ {{- .Body.TodayReflect.RefText -}} }{%
  \begin{tabular}{@{}l|l}
    \multirow{2}{*}{\resizebox{!}{.5cm}{ {{- .Body.TodayReflect.Day -}} }} & \textbf{ {{- .Body.TodayReflect.Weekday -}} } \\
    & {{- .Body.TodayReflect.Month -}}
  \end{tabular}%
}
{{- end -}}
{{if is .Body.Notes}}
\hypertarget{ {{- .Body.Notes -}} }{}%
  \resizebox{!}{.5cm}{ {{- .Body.Notes -}} }
{{- end -}}
{{if is .Body.Todos}}
\hypertarget{ {{- .Body.Todos -}} }{}%
\resizebox{!}{.5cm}{ {{- .Body.Todos -}} }
{{- end -}}
\hfill
{\renewcommand{\arraystretch}{\myNumArrayStretch}
\begin{tabular}{*{3}{c|}@{}}
  {{if is .Body.Year}}\cellcolor{black}{\color{white}{Calendar}}{{else}}\hyperlink{ {{- .Body.Year -}} }{Calendar}{{end}}
  &
  {{if is .Body.Todos -}}
  {{- if eq .Body.Todos "Todos Index" -}}
  \cellcolor{black}{\color{white}{To Do}}
  {{- else -}}
  \hyperlink{Todos Index}{To Do}
  {{- end -}}
  {{- else -}}\hyperlink{Todos Index}{To Do}{{end}}
  &
  {{if is .Body.Notes -}}
    {{- if eq .Body.Notes "Notes Index" -}}
      \cellcolor{black}{\color{white}{Notes}}
    {{- else -}}
      \hyperlink{Notes Index}{Notes}
    {{- end -}}
  {{- else -}}\hyperlink{Notes Index}{Notes}{{end}}
\end{tabular}}%
\medskip
\myLineThick
\marginnote{%
  \rotatebox[origin=tr]{90}{%
    \renewcommand{\arraystretch}{2}%
    \begin{tabularx}{14.35cm}{*{11}{Y|}Y}
      {{range $i, $month := .Body.Months -}}
        {{$month.Hyper}} {{if ne $i 11}} & {{else}} \\ \hline {{end}}
      {{end}}
    \end{tabularx}%
    \quad
    \begin{tabularx}{4cm}{*{3}{Y|}Y}
    {{range $i, $quarter := .Body.Quarters -}}
      {{$quarter.Hyper}} {{if ne $i 3}} & {{else}} \\ \hline {{end}}
    {{end}}
    \end{tabularx}%
  }%
}%
\medskip