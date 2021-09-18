\begin{minipage}[t]{\myLenTriCol}
  {{template "hours.tpl" dict "Cfg" .Cfg "Hours" .Body.Hours}}
  \vspace{\dimexpr4mm+.3pt}

  {{template "monthTabular.tpl" dict "Cfg" .Cfg "Month" .Body.Month "HideName" true "UseTabularx" true "Today" .Body.Today }}
\end{minipage}%
\hspace{\myLenTriColSep}%
\begin{minipage}[t]{\dimexpr2\myLenTriCol+\myLenTriColSep}
  \myUnderline{Top priorities\textcolor{white}{g}}
  \Repeat{\myNumDailyTodos}{\myTodoLineGray}
  \vskip\dimexpr7mm-1.4pt
  \myUnderline{Notes\hfill\hyperlink{Notes {{- .Body.Today.RefText -}} }{More}}
  \Repeat{\myNumDailyNotes}{\myLineGrayVskipTop}
  \vskip\dimexpr7mm-1.2pt
  \myUnderline{Personal\hfill\hyperlink{Reflect {{- .Body.Today.RefText -}} }{Reflect}}
  \Repeat{\myNumDailyPersonal}{\myLineGrayVskipTop}
\end{minipage}
\par\pagebreak
