\ExplSyntaxOn
\cs_new_eq:NN \Repeat \prg_replicate:nn
\ExplSyntaxOff

\newcommand{\myNumArrayStretch}{ {{- .Cfg.Layout.Numbers.ArrayStretch -}} }
\newcommand{\myNumQuarterlyLines}{ {{- .Cfg.Layout.Numbers.QuarterlyLines -}} }

\newlength{\myLenTabColSep}
\newlength{\myLenLineThicknessDefault}
\newlength{\myLenLineThicknessThick}
\newlength{\myLenLineHeightButLine}

\setlength{\myLenTabColSep}{ {{- .Cfg.Layout.Lengths.TabColSep -}} }
\setlength{\myLenLineThicknessDefault}{ {{- .Cfg.Layout.Lengths.LineThicknessDefault -}} }
\setlength{\myLenLineThicknessThick}{ {{- .Cfg.Layout.Lengths.LineThicknessThick -}} }
\setlength{\myLenLineHeightButLine}{ {{- .Cfg.Layout.Lengths.LineHeightButLine -}} }

\newcommand{\myColorGray}{ {{- .Cfg.Layout.Colors.Gray -}} }

\newcommand{\myLinePlain}{\hrule width \linewidth height \myLenLineThicknessDefault}
\newcommand{\myLineThick}{\hrule width \linewidth height \myLenLineThicknessThick}

\newcommand{\myLineColor}[1]{\textcolor{#1}{\myLinePlain}}
\newcommand{\myLineGray}{\myLineColor{\myColorGray}}
\newcommand{\myLineGrayVskipBottom}{\myLineGray\vskip\myLenLineHeightButLine}
