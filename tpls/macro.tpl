\ExplSyntaxOn
\cs_new_eq:NN \Repeat \prg_replicate:nn
\ExplSyntaxOff

\newcommand{\myNumArrayStretch}{ {{- .Cfg.Layout.Numbers.ArrayStretch -}} }

\newlength{\myLenTabColSep}
\setlength{\myLenTabColSep}{ {{- .Cfg.Layout.Lengths.TabColSep -}} }