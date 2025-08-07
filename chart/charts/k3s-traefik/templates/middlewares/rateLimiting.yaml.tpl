{{- if .Values.enabled }}{{- if .Values.middlewares.rateLimiting.enabled }}
apiVersion: traefik.io/v1alpha1
kind: Middleware
metadata:
  name: ratelimit
  annotations:
    argocd.argoproj.io/sync-wave: "-3"
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
    {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if .Values.global.commonLabels }}
  labels:
    # Global labels
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
  {{- end }}
spec:
  rateLimit:
    period: {{ .Values.middlewares.rateLimiting.period }}
    average: {{ .Values.middlewares.rateLimiting.average }}
    burst: {{ .Values.middlewares.rateLimiting.burst }}
{{- end }}{{- end }}