{%
\renewcommand{\arraystretch}{\myNumArrayStretch}%
\setlength{\tabcolsep}{\myLenTabColSep}%
\begin{tabular}[t]{ {{- .Month.WeekLayout .Cfg.Blocks.Weekly.Enabled -}} }
\multicolumn{ {{- .Month.WeekHeaderLen .Cfg.Blocks.Weekly.Enabled -}} }{c}{ {{- .Month.MonthName -}} } \\ \hline
{{.Month.WeekHeader .Cfg.Blocks.Weekly.Enabled}} \\ \hline
{{.Month.DaysMatrix .Cfg.Blocks.Weekly.Enabled}}
\end{tabular}}