{{template "header_margin_quarters_months.tpl" dict "Today" .Body.Today}}

\begin{minipage}[t]{\myLenTriCol}
  \myUnderline{Schedule\textcolor{white}{g}}
  \foreach \x in {\myNumDailyBottomHour,...,\myNumDailyTopHour}
    {\myLineHeightButLine\x\myLineLightGray\vskip\myLenLineHeightButLine\myLineGray}
  \vspace{\dimexpr4mm+.3pt}

  {{template "monthTabular.tpl" dict "Cfg" .Cfg "Month" .Body.Month "HideName" true "UseTabularx" true }}
\end{minipage}%
\hspace{\myLenTriColSep}%
\begin{minipage}[t]{\dimexpr2\myLenTriCol+\myLenTriColSep}
  \myUnderline{Top priorities\textcolor{white}{g}}
  \Repeat{5}{\myTodoLineGray}
  \vskip\dimexpr7mm-1.4pt
  \myUnderline{Notes}
  \Repeat{16}{\myLineGrayVskipTop}
  \vskip\dimexpr7mm-1.2pt
  \myUnderline{Personal}
  \Repeat{9}{\myLineGrayVskipTop}
\end{minipage}
\par\pagebreak
