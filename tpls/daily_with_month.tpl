\begin{tabular}{l|l}
  \multirow{2}{*}{\scalebox{4}{ {{- .Body.Today.Day -}} }} & \textbf{ {{- .Body.Today.Weekday -}} } \\
  & {{- .Body.Today.Month -}}
\end{tabular}
\medskip
\myLineThick
\marginnote{%
  \rotatebox[origin=tr]{90}{%
    \renewcommand{\arraystretch}{2}%
    \begin{tabularx}{14.35cm}{*{11}{Y|}Y}
      Dec &
      Nov &
      Oct &
      \cellcolor{black}{\textcolor{white}{Sep}} &
      Aug &
      Jul &
      Jun &
      May &
      Apr &
      Mar &
      Feb &
      Jan \\ \hline
    \end{tabularx}%
    \quad
    \begin{tabularx}{4cm}{*{3}{Y|}Y}
      Q4 & Q3 & Q2 & Q1 \\ \hline
    \end{tabularx}%
  }%
}%
\medskip

\begin{minipage}[t]{\myLenTriCol}
  \myUnderline{Schedule\textcolor{white}{g}}
  \foreach \x in {\myNumDailyBottomHour,...,\myNumDailyTopHour}
    {\myLineGray\myLineHeightButLine\x\myLineLightGray\vskip\myLenLineHeightButLine}
  \vfill

  {{template "monthTabular.tpl" dict "Cfg" .Cfg "Month" .Body.Month "HideName" true "UseTabularx" true }}
\end{minipage}%
\hspace{\myLenTriColSep}%
\begin{minipage}[t]{\dimexpr2\myLenTriCol+\myLenTriColSep}
  \myUnderline{Top priorities\textcolor{white}{g}}
  \Repeat{5}{\myTodoLineGray}
  \vskip\dimexpr7mm-1.2pt
  \myUnderline{Notes}
  \Repeat{\myNumDailyNotes}{\myLineGrayVskipTop}
  \vskip\dimexpr7mm-1.2pt
  \myUnderline{Personal}
  \Repeat{7}{\myLineGrayVskipTop}
\end{minipage}