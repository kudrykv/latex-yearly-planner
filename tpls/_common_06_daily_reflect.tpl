\myUnderline{Things I'm grateful for}
\myMash{\myNumDailyDiaryGrateful}{\myNumDotWidthFull}
\medskip

\myUnderline{The best thing that happened today}
\myMash{\myNumDailyDiaryBest}{\myNumDotWidthFull}
\medskip

{{ if $.Cfg.DailyReflectShowLocationUploaded -}}
    \myUnderline{Daily log\hfill\textit{location:}\hfill\hfill\hfill{\myLineHeightButLine$\square$ \textit{uploaded}}}
{{ else -}}
    \myUnderline{Daily log}
{{ end }}
\myMash{\myNumDailyDiaryLog}{\myNumDotWidthFull}
