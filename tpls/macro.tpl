\ExplSyntaxOn
\cs_new_eq:NN \Repeat \prg_replicate:nn
\ExplSyntaxOff

\newcommand{\myNumArrayStretch}{ {{- .Cfg.Layout.Numbers.ArrayStretch -}} }

\newlength{\myLenTabColSep}
\newlength{\myLenLineThicknessDefault}
\newlength{\myLenLineThicknessThick}

\setlength{\myLenTabColSep}{ {{- .Cfg.Layout.Lengths.TabColSep -}} }
\setlength{\myLenLineThicknessDefault}{ {{- .Cfg.Layout.Lengths.LineThicknessDefault -}} }
\setlength{\myLenLineThicknessThick}{ {{- .Cfg.Layout.Lengths.LineThicknessThick -}} }

\newcommand{\myLineThick}{\hrule width \linewidth height \myLenLineThicknessThick}