\begin{minipage}[t]{\myLenTriCol}
  \myUnderline{Schedule\textcolor{white}{g}}
  \foreach \x in {\myNumDailyBottomHour,...,\myNumDailyTopHour}
    {\myLineHeightButLine\x\myLineLightGray\vskip\myLenLineHeightButLine\myLineGray}
  \vspace{\dimexpr4mm+.3pt}

  {{template "monthTabular.tpl" dict "Cfg" .Cfg "Month" .Body.Month "HideName" true "UseTabularx" true "Today" .Body.Today }}
\end{minipage}%
\hspace{\myLenTriColSep}%
\begin{minipage}[t]{\dimexpr2\myLenTriCol+\myLenTriColSep}
  \myUnderline{Top priorities\textcolor{white}{g}}
  \Repeat{5}{\myTodoLineGray}
  \vskip\dimexpr7mm-1.4pt
  \myUnderline{Notes\hfill\hyperlink{Notes {{- .Body.Today.RefText -}} }{More}}
  \Repeat{16}{\myLineGrayVskipTop}
  \vskip\dimexpr7mm-1.2pt
  \myUnderline{Personal\hfill\hyperlink{Reflect {{- .Body.Today.RefText -}} }{Reflect}}
  \Repeat{9}{\myLineGrayVskipTop}
\end{minipage}
\par\pagebreak
