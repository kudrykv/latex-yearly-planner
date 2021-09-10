\hypertarget{ {{- .Today.RefText -}} }{}\begin{tabular}{l|l}
  \multirow{2}{*}{\scalebox{4}{ {{- .Today.Day -}} }} & \textbf{ {{- .Today.Weekday -}} } \\
  & {{- .Today.Month -}}
\end{tabular}
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
      {{if eq .Today.Month.String "December" }}\cellcolor{black}{\textcolor{white}{Dec}}{{else}}Dec{{end}} &
      {{if eq .Today.Month.String "November" }}\cellcolor{black}{\textcolor{white}{Nov}}{{else}}Nov{{end}} &
      {{if eq .Today.Month.String "October" }}\cellcolor{black}{\textcolor{white}{Oct}}{{else}}Oct{{end}} &
      {{if eq .Today.Month.String "September" }}\cellcolor{black}{\textcolor{white}{Sep}}{{else}}Sep{{end}} &
      {{if eq .Today.Month.String "August" }}\cellcolor{black}{\textcolor{white}{Aug}}{{else}}Aug{{end}} &
      {{if eq .Today.Month.String "July" }}\cellcolor{black}{\textcolor{white}{Jul}}{{else}}Jul{{end}} &
      {{if eq .Today.Month.String "June" }}\cellcolor{black}{\textcolor{white}{Jun}}{{else}}Jun{{end}} &
      {{if eq .Today.Month.String "May" }}\cellcolor{black}{\textcolor{white}{May}}{{else}}May{{end}} &
      {{if eq .Today.Month.String "April" }}\cellcolor{black}{\textcolor{white}{Apr}}{{else}}Apr{{end}} &
      {{if eq .Today.Month.String "March" }}\cellcolor{black}{\textcolor{white}{Mar}}{{else}}Mar{{end}} &
      {{if eq .Today.Month.String "February" }}\cellcolor{black}{\textcolor{white}{Feb}}{{else}}Feb{{end}} &
      {{if eq .Today.Month.String "January" }}\cellcolor{black}{\textcolor{white}{Jan}}{{else}}Jan{{end}} \\ \hline
    \end{tabularx}%
    \quad
    \begin{tabularx}{4cm}{*{3}{Y|}Y}
      Q4 & Q3 & Q2 & Q1 \\ \hline
    \end{tabularx}%
  }%
}%
\medskip