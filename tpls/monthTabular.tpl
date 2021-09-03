{%
\renewcommand{\arraystretch}{\myNumArrayStretch}%
\setlength{\tabcolsep}{\myLenTabColSep}%
\begin{tabular}[t]{ {{- .Month.WeekLayout .Cfg.WithWeeks -}} }
\multicolumn{ {{- .Month.WeekHeaderLen .Cfg.WithWeeks -}} }{c}{ {{- .Month.MonthName -}} } \\ \hline
{{.Month.WeekHeader .Cfg.WithWeeks}} \\ \hline
{{.Month.DaysMatrix .Cfg.WithWeeks}}
\end{tabular}}