{{/* Define the secret */}}
{{- define "homebox.secret" -}}

{{- $secretName := printf "%s-homebox-secret" (include "tc.common.names.fullname" .) }}

---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  HBOX_MODE: production
  HBOX_SWAGGER_SCHEMA: {{ .Values.service.main.ports.main.protocol | lower }}
  HBOX_STORAGE_DATA: {{ .Values.persistence.data.mountPath }}
  HBOX_WEB_PORT: {{ .Values.service.main.ports.main.port | quote }}
  HBOX_SWAGGER_HOST: {{ .Values.service.main.ports.main.port | quote }}
  {{/* User Defined */}}
  HBOX_OPTIONS_ALLOWREGISTRATION: {{ .Values.homebox.allow_registration | quote }}
  HBOX_OPTIONS_AUTO_INCREMENT_ASSET_ID: {{ .Values.homebox.auto_increment_asset_id | quote }}
  HBOX_WEB_MAX_UPLOAD_SIZE: {{ (.Values.homebox.max_upload_size | default 10) | quote }}
  HBOX_LOG_LEVEL: {{ .Values.homebox.log_level | default "info" }}
  HBOX_LOG_FORMAT: {{ .Values.homebox.log_format | default "text" }}
  {{- if .Values.homebox.mailer_host }}
  HBOX_MAILER_HOST: {{ .Values.homebox.mailer_host }}
  HBOX_MAILER_PORT: {{ .Values.homebox.mailer_port }}
  HBOX_MAILER_FROM: {{ .Values.homebox.mailer_from }}
  HBOX_MAILER_USERNAME: {{ .Values.homebox.mailer_username }}
  HBOX_MAILER_PASSWORD: {{ .Values.homebox.mailer_password }}
  {{- end }}
{{- end }}
