\ExplSyntaxOn
\cs_new_eq:NN \Repeat \prg_replicate:nn
\ExplSyntaxOff

\newcommand{\myNumArrayStretch}{ {{- .Cfg.Layout.Numbers.ArrayStretch -}} }
\newcommand{\myNumQuarterlyLines}{ {{- .Cfg.Layout.Numbers.QuarterlyLines -}} }

\newlength{\myLenTabColSep}
\newlength{\myLenLineThicknessDefault}
\newlength{\myLenLineThicknessThick}
\newlength{\myLenLineHeightButLine}
\newlength{\myLenTwoColSep}
\newlength{\myLenTwoCol}

\setlength{\myLenTabColSep}{ {{- .Cfg.Layout.Lengths.TabColSep -}} }
\setlength{\myLenLineThicknessDefault}{ {{- .Cfg.Layout.Lengths.LineThicknessDefault -}} }
\setlength{\myLenLineThicknessThick}{ {{- .Cfg.Layout.Lengths.LineThicknessThick -}} }
\setlength{\myLenLineHeightButLine}{ {{- .Cfg.Layout.Lengths.LineHeightButLine -}} }
\setlength{\myLenTwoColSep}{ {{- .Cfg.Layout.Lengths.TwoColSep -}} }
\setlength{\myLenTwoCol}{\dimexpr.5\linewidth-\myLenTwoCol}

\newcommand{\myColorGray}{ {{- .Cfg.Layout.Colors.Gray -}} }

\newcommand{\myLinePlain}{\hrule width \linewidth height \myLenLineThicknessDefault}
\newcommand{\myLineThick}{\hrule width \linewidth height \myLenLineThicknessThick}

\newcommand{\myUnderline}[1]{#1\vskip1mm\myLineThick\par}
\newcommand{\myLineColor}[1]{\textcolor{#1}{\myLinePlain}}
\newcommand{\myLineGray}{\myLineColor{\myColorGray}}
\newcommand{\myLineGrayVskipBottom}{\myLineGray\vskip\myLenLineHeightButLine}
