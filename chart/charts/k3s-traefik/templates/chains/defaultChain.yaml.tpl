{{- if .Values.enabled -}}{{- if .Values.middlewares.enabled -}}
apiVersion: traefik.io/v1alpha1
kind: Middleware
metadata:
  name: traefik-default-chain
  namespace: {{ .Release.Namespace | quote }}
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
    {{- if .Values.middlewares.rateLimiting.enabled }}{{- if .Values.middlewares.rateLimiting.inDefaultChain }}
    - name: ratelimit
    {{- end }}{{- end }}
    - name: redirect-to-https
    - name: default-headers
    {{- if .Values.middlewares.crowdsecBouncer.enabled }}{{- if .Values.middlewares.crowdsecBouncer.inDefaultChain }}
    - name: bouncer
    {{- end }}{{- end }}
    {{- if .Values.middlewares.localOnlyAllowlist.enabled }}{{- if .Values.middlewares.localOnlyAllowlist.inDefaultChain }}
    - name: lan-only
    {{- end }}{{- end }}
    {{- if .Values.middlewares.autheliaForwardAuth.enabled }}{{- if .Values.middlewares.autheliaForwardAuth.inDefaultChain }}
    - name: authelia-forward-auth
    {{- end }}{{- end }}
    {{- if .Values.middlewares.authentikForwardAuth.enabled }}{{- if .Values.middlewares.authentikForwardAuth.inDefaultChain }}
    - name: authentik-forward-auth
    {{- end }}{{- end }}
{{- end }}{{- end }}