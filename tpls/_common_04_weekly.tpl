{{ if $.Cfg.Dotted -}}
  {{ template "_common_04_weekly_dotted.tpl" dict "Cfg" .Cfg "Body" .Body }}
{{- else -}}
  {{ template "_common_04_weekly_lined.tpl" dict "Cfg" .Cfg "Body" .Body }}
{{- end }}
