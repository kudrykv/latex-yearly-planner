\myUnderline{Schedule\textcolor{white}{g}}\vskip-\myLenLineThicknessDefault

{{range $hour := .Day.Hours .Cfg.Layout.Numbers.DailyBottomHour .Cfg.Layout.Numbers.DailyBottomHourEnd -}}
\myLineHeightButLine%
{{if $.Cfg.AMPMTime -}}
\parbox{9mm}{\hfill\small\textcolor{\myColorGray}{ {{- $hour.FormatHour $.Cfg.AMPMTime -}} }}%
{{- else -}}
{\small {{- $hour.FormatHour $.Cfg.AMPMTime -}} }
{{- end}}
\myLineLightGray\vskip\myLenLineHeightButLine\myLineGray
{{- end}}
{{ if $.Cfg.ScheduleIncludeWorkingHours -}}
\colorbox{gray!40}{%
    \noindent\parbox{\linewidth - 2\fboxsep}{%
{{- end}}
{{range $hour := .Day.Hours .Cfg.Layout.Numbers.DailyBusBottomHour .Cfg.Layout.Numbers.DailyBusTopHour -}}
\myLineHeightButLine%
{{if $.Cfg.AMPMTime -}}
\parbox{9mm}{\hfill\small\textcolor{\myColorGray}{ {{- $hour.FormatHour $.Cfg.AMPMTime -}} }}%
{{- else -}}
{\small {{- $hour.FormatHour $.Cfg.AMPMTime -}} }
{{- end}}
\myLineLightGray\vskip\myLenLineHeightButLine\myLineGray
{{- end}}
{{ if $.Cfg.ScheduleIncludeWorkingHours -}}
}}
{{- end}}
{{range $hour := .Day.Hours .Cfg.Layout.Numbers.DailyTopHourStart .Cfg.Layout.Numbers.DailyTopHour -}}
\myLineHeightButLine%
{{if $.Cfg.AMPMTime -}}
\parbox{9mm}{\hfill\small\textcolor{\myColorGray}{ {{- $hour.FormatHour $.Cfg.AMPMTime -}} }}%
{{- else -}}
{\small {{- $hour.FormatHour $.Cfg.AMPMTime -}} }
{{- end}}
\myLineLightGray\vskip\myLenLineHeightButLine\myLineGray
{{- end}}
{{if $.Cfg.AddLastHalfHour}}\vskip\myLenLineHeightButLine\vbox to 0pt{\myLineLightGray}{{end}}
