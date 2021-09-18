\myUnderline{Schedule\textcolor{white}{g}}\vskip-\myLenLineThicknessDefault
{{range $hour := .Hours -}}
  \myLineGray\myLineHeightButLine%
  {{if $.Cfg.AMPMTime -}}
    \parbox{9mm}{\hfill\small {{- $hour.FormatHour $.Cfg.AMPMTime -}} }%
  {{- else -}}
    {\small {{- $hour.FormatHour $.Cfg.AMPMTime -}} }
  {{- end}}
  \myLineLightGray\vskip\myLenLineHeightButLine
{{- end}}
\myLineGrayVskipBottom\myLineLightGray