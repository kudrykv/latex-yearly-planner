\ExplSyntaxOn
\cs_new_eq:NN \Repeat \prg_replicate:nn
\ExplSyntaxOff

\newcommand{\myMinLineHeight}[1]{\parbox{0pt}{\vskip#1}}

\newcommand{\myNumArrayStretch}{ {{- .Cfg.Layout.Numbers.ArrayStretch -}} }
\newcommand{\myNumQuarterlyLines}{ {{- .Cfg.Layout.Numbers.QuarterlyLines -}} }
\newcommand{\myNumWeeklyLines}{ {{- .Cfg.Layout.Numbers.WeeklyLines -}} }
\newcommand{\myNumDailyTodos}{ {{- .Cfg.Layout.Numbers.DailyTodos -}} }
\newcommand{\myNumDailyNotes}{ {{- .Cfg.Layout.Numbers.DailyNotes -}} }
\newcommand{\myNumDailyBottomHour}{ {{- .Cfg.Layout.Numbers.DailyBottomHour -}} }
\newcommand{\myNumDailyTopHour}{ {{- .Cfg.Layout.Numbers.DailyTopHour -}} }
\newcommand{\myNumDailyDiaryGoals}{ {{- .Cfg.Layout.Numbers.DailyDiaryGoals -}} }
\newcommand{\myNumDailyDiaryGrateful}{ {{- .Cfg.Layout.Numbers.DailyDiaryGrateful -}} }
\newcommand{\myNumDailyDiaryBest}{ {{- .Cfg.Layout.Numbers.DailyDiaryBest -}} }
\newcommand{\myNumDailyDiaryLog}{ {{- .Cfg.Layout.Numbers.DailyDiaryLog -}} }

\newlength{\myLenTabColSep}
\newlength{\myLenLineThicknessDefault}
\newlength{\myLenLineThicknessThick}
\newlength{\myLenLineHeightButLine}
\newlength{\myLenTwoColSep}
\newlength{\myLenTwoCol}
\newlength{\myLenTriColSep}
\newlength{\myLenTriCol}
\newlength{\myLenMonthlyCellHeight}

\setlength{\myLenTabColSep}{ {{- .Cfg.Layout.Lengths.TabColSep -}} }
\setlength{\myLenLineThicknessDefault}{ {{- .Cfg.Layout.Lengths.LineThicknessDefault -}} }
\setlength{\myLenLineThicknessThick}{ {{- .Cfg.Layout.Lengths.LineThicknessThick -}} }
\setlength{\myLenLineHeightButLine}{ {{- .Cfg.Layout.Lengths.LineHeightButLine -}} }
\setlength{\myLenTwoColSep}{ {{- .Cfg.Layout.Lengths.TwoColSep -}} }
\setlength{\myLenTwoCol}{\dimexpr.5\linewidth-.5\myLenTwoColSep}
\setlength{\myLenMonthlyCellHeight}{ {{- .Cfg.Layout.Lengths.MonthlyCellHeight -}} }
\setlength{\myLenTriColSep}{ {{- .Cfg.Layout.Lengths.TriColSep -}} }
\setlength{\myLenTriCol}{\dimexpr.333\linewidth-.667\myLenTriColSep}

\newcommand{\myColorGray}{ {{- .Cfg.Layout.Colors.Gray -}} }
\newcommand{\myColorLightGray}{ {{- .Cfg.Layout.Colors.LightGray -}} }

\newcommand{\myLinePlain}{\hrule width \linewidth height \myLenLineThicknessDefault}
\newcommand{\myLineThick}{\hrule width \linewidth height \myLenLineThicknessThick}

\newcommand{\myLineHeightButLine}{\myMinLineHeight{\myLenLineHeightButLine}}
\newcommand{\myUnderline}[1]{#1\vskip1mm\myLineThick\par}
\newcommand{\myLineColor}[1]{\textcolor{#1}{\myLinePlain}}
\newcommand{\myLineGray}{\myLineColor{\myColorGray}}
\newcommand{\myLineLightGray}{\myLineColor{\myColorLightGray}}
\newcommand{\myLineGrayVskipBottom}{\myLineGray\vskip\myLenLineHeightButLine}
\newcommand{\myLineGrayVskipTop}{\vskip\myLenLineHeightButLine\myLineGray}

\newcommand{\myTodo}{\myLineHeightButLine$\square$\myLinePlain}
\newcommand{\myTodoLineGray}{\myLineHeightButLine$\square$\myLineGray}