{{- define "influxdb.name" -}}
{{- default .Chart.Name .Values.nameOverride -}}
{{- end -}}

{{- define "influxdb.fullname" -}}
{{- printf "%s-%s" .Release.Name (include "influxdb.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}