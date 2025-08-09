{{- if .Values.enabled }}{{- if .Values.middlewares.enabled }}{{- if .Values.middlewares.authentikForwardAuth.enabled }}
apiVersion: traefik.io/v1alpha1
kind: Middleware
metadata:
  name: authentik-forward-auth
  namespace: {{ .Release.Namespace | quote }}
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
  forwardAuth:
    address: {{ .Values.middlewares.authentikForwardAuth.url | quote }}
    trustForwardHeader: true
    authResponseHeaders:
      - X-authentik-username
      - X-authentik-groups
      - X-authentik-email
      - X-authentik-name
      - X-authentik-uid
      - X-authentik-jwt
      - X-authentik-meta-jwks
      - X-authentik-meta-outpost
      - X-authentik-meta-provider
      - X-authentik-meta-app
      - X-authentik-meta-version
{{- end }}{{- end }}{{- end }}