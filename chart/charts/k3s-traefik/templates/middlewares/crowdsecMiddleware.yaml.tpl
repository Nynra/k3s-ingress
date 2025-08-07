apiVersion: traefik.io/v1alpha1
kind: Middleware
metadata:
  name: bouncer
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
  plugin:
    bouncer:
      enabled: {{ .Values.middlewares.crowdsecBouncer.enabled | quote }}
      logLevel: DEBUG
      crowdsecMode: stream
      crowdsecLapiScheme: https
      crowdsecLapiHost: crowdsec-service.{{ .Release.Namespace }}:8080
      crowdsecLapiKey: mysecretkey12345

