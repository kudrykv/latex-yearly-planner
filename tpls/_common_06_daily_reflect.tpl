\myUnderline{Things I'm grateful for}
\myMash{\myNumDailyDiaryGrateful}{\myNumDotWidthFull}
\medskip

\myUnderline{The best thing that happened today}
\myMash{\myNumDailyDiaryBest}{\myNumDotWidthFull}
\medskip

{{ if $.Cfg.DailyReflectShowLocationUploaded -}}
    \myUnderline{Journal\hfill\textit{location:}\hfill\hfill\hfill{\myLineHeightButLine$\square$ \textit{uploaded}} \vskip -2pt}
{{ else -}}
    \myUnderline{Journal \vspace{2pt}}
{{ end }}
\myMash{\myNumDailyDiaryLog}{\myNumDotWidthFull}
