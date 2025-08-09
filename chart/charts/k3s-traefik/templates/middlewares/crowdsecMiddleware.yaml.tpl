{{- if .Values.enabled }}{{- if .Values.middlewares.enabled }}{{- if .Values.middlewares.bouncer.enabled }}
apiVersion: traefik.io/v1alpha1
kind: Middleware
metadata:
  name: bouncer
  annotations:
    argocd.argoproj.io/sync-wave: "1"
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
  plugin:
    bouncer:
      enabled: {{ .Values.middlewares.crowdsecBouncer.enabled | quote }}
      logLevel: DEBUG
      crowdsecMode: stream
      crowdsecLapiScheme: https
      crowdsecLapiHost: "{{ .Release.Name }}-service.{{ .Release.Namespace }}.svc.cluster.local:8080"
      crowdsecLapiTLSCertificateAuthorityFile: /etc/traefik/crowdsec-certs/ca.crt
      crowdsecLapiTLSCertificateBouncerFile: /etc/traefik/crowdsec-certs/tls.crt
      crowdsecLapiTLSCertificateBouncerKeyFile: /etc/traefik/crowdsec-certs/tls.key
{{- end }}{{- end }}{{- end }}
