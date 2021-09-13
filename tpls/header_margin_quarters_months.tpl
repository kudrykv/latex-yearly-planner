{{if is .Body.Year}}
\begin{tabular}{@{}l}
  \resizebox{!}{.5cm}{\hypertarget{ {{- .Body.Year -}} }{ {{- .Body.Year -}} }}
\end{tabular}
{{- end -}}
{{if is .Body.Quarter}}
\begin{tabular}{@{}l}
  \resizebox{!}{.5cm}{\hypertarget{Q {{- .Body.Quarter -}} }{Q {{- .Body.Quarter -}} }}
\end{tabular}
{{- end -}}
{{if is .Body.Month}}
\begin{tabular}{@{}l}
  \resizebox{!}{.5cm}{\hypertarget{ {{- .Body.Month.Month -}} }{ {{- .Body.Month.Month -}} }}
\end{tabular}
{{- end -}}
{{if is .Body.Week}}
\begin{tabular}{@{}l}
  \resizebox{!}{.5cm}{\hypertarget{ {{- .Body.Week.RefText "" -}} }{Week {{.Body.Week.WeekNumber -}} }}
\end{tabular}
{{- end -}}
{{ if is .Body.Today}}
\hypertarget{ {{- .Body.Today.RefText -}} }{}%
\begin{tabular}{@{}l|l}
  \multirow{2}{*}{\resizebox{!}{.5cm}{ {{- .Body.Today.Day -}} }} & \textbf{ {{- .Body.Today.Weekday -}} } \\
  & {{- .Body.Today.Month -}}
\end{tabular}
{{- end -}}
\hfill
\begin{tabular}{*{5}{c|}@{}}
  Calendar & To Do & Meetings & Lists & Notes
\end{tabular}%
\medskip
\myLineThick
\marginnote{%
  \rotatebox[origin=tr]{90}{%
    \renewcommand{\arraystretch}{2}%
    \begin{tabularx}{14.35cm}{*{11}{Y|}Y}
    {{if is .Body.Date}}
      {{- if eq .Body.Date.Month.String "December" -}}
        \cellcolor{black}{\textcolor{white}{\hypertarget{December}{Dec}}}
      {{- else -}}
        \hyperlink{December}{Dec}
      {{- end}} &
      {{- if eq .Body.Date.Month.String "November" -}}
        \cellcolor{black}{\textcolor{white}{\hypertarget{November}{Nov}}}
      {{- else -}}
        \hyperlink{November}{Nov}
      {{- end}} &
      {{- if eq .Body.Date.Month.String "October" -}}
        \cellcolor{black}{\textcolor{white}{\hypertarget{October}{Oct}}}
      {{- else -}}
        \hyperlink{October}{Oct}
      {{- end}} &
      {{- if eq .Body.Date.Month.String "September" -}}
        \cellcolor{black}{\textcolor{white}{\hypertarget{September}{Sep}}}
      {{- else -}}
        \hyperlink{September}{Sep}
      {{- end}} &
      {{- if eq .Body.Date.Month.String "August" -}}
        \cellcolor{black}{\textcolor{white}{\hypertarget{August}{Aug}}}
      {{- else -}}
        \hyperlink{August}{Aug}
      {{- end}} &
      {{- if eq .Body.Date.Month.String "July" -}}
        \cellcolor{black}{\textcolor{white}{\hypertarget{July}{Jul}}}
      {{- else -}}
        \hyperlink{July}{Jul}
      {{- end}} &
      {{- if eq .Body.Date.Month.String "June" -}}
        \cellcolor{black}{\textcolor{white}{\hypertarget{June}{Jun}}}
      {{- else -}}
        \hyperlink{June}{Jun}
      {{- end}} &
      {{- if eq .Body.Date.Month.String "May" -}}
        \cellcolor{black}{\textcolor{white}{\hypertarget{May}{May}}}
      {{- else -}}
        \hyperlink{May}{May}
      {{- end}} &
      {{- if eq .Body.Date.Month.String "April" -}}
        \cellcolor{black}{\textcolor{white}{\hypertarget{April}{Apr}}}
      {{- else -}}
        \hyperlink{April}{Apr}
      {{- end}} &
      {{- if eq .Body.Date.Month.String "March" -}}
        \cellcolor{black}{\textcolor{white}{\hypertarget{March}{Mar}}}
      {{- else -}}
        \hyperlink{March}{Mar}
      {{- end}} &
      {{- if eq .Body.Date.Month.String "February" -}}
        \cellcolor{black}{\textcolor{white}{\hypertarget{February}{Feb}}}
      {{- else -}}
        \hyperlink{February}{Feb}
      {{- end}} &
      {{- if eq .Body.Date.Month.String "January" -}}
        \cellcolor{black}{\textcolor{white}{\hypertarget{January}{Jan}}}
      {{- else -}}
        \hyperlink{January}{Jan}
    {{- end}} \\ \hline
    {{- else -}}
      \hyperlink{December}{Dec} &
      \hyperlink{November}{Nov} &
      \hyperlink{October}{Oct} &
      \hyperlink{September}{Sep} &
      \hyperlink{August}{Aug} &
      \hyperlink{July}{Jul} &
      \hyperlink{June}{Jun} &
      \hyperlink{May}{May} &
      \hyperlink{April}{Apr} &
      \hyperlink{March}{Mar} &
      \hyperlink{February}{Feb} &
      \hyperlink{January}{Jan} \\ \hline
    {{end}}
    \end{tabularx}%
    \quad
    \begin{tabularx}{4cm}{*{3}{Y|}Y}
    {{ if is .Body.Quarter}}
      {{if eq .Body.Quarter 4 -}}
        \cellcolor{black}{\textcolor{white}{\hypertarget{Q4}{Q4}}}
      {{- else -}}
        \hyperlink{Q4}{Q4}
      {{- end -}} &
      {{if eq .Body.Quarter 3 -}}
        \cellcolor{black}{\textcolor{white}{\hypertarget{Q3}{Q3}}}
      {{- else -}}
        \hyperlink{Q3}{Q3}
      {{- end -}} &
      {{if eq .Body.Quarter 2 -}}
        \cellcolor{black}{\textcolor{white}{\hypertarget{Q2}{Q2}}}
      {{- else -}}
        \hyperlink{Q2}{Q2}
      {{- end -}} &
      {{if eq .Body.Quarter 1 -}}
        \cellcolor{black}{\textcolor{white}{\hypertarget{Q1}{Q1}}}
      {{- else -}}
        \hyperlink{Q1}{Q1}
      {{- end -}} \\ \hline
    {{else}}
      \hyperlink{Q4}{Q4} &
      \hyperlink{Q3}{Q3} &
      \hyperlink{Q2}{Q2} &
      \hyperlink{Q1}{Q1} \\ \hline
    {{end}}
    \end{tabularx}%
  }%
}%
\medskip