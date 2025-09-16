{{- if .Values.enabled -}}{{- if .Values.middlewares.enabled }}
{{- range .Values.middlewares.chains }}
apiVersion: traefik.io/v1alpha1
kind: Middleware
metadata:
  name: {{ .name }}
  namespace: {{ $.Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "2"
    # Global annotations
    {{- if $.Values.global.commonAnnotations }}
    {{- toYaml $.Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if $.Values.global.commonLabels }}
  labels:
    # Global labels
    {{- toYaml $.Values.global.commonLabels | nindent 4 }}
  {{- end }}
spec:
  chain:
    middlewares:
    {{- range .middlewares }}
    - name: {{ . }}
    {{- end }}
---
{{- end }}
{{- end }}{{- end }}
