{{- if .Values.enabled }}{{- if .Values.middlewares.localOnlyAllowlist.enabled }}
apiVersion: traefik.io/v1alpha1
kind: Middleware
metadata:
  name: lan-only
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
  ipWhiteList:
    sourceRange:
      {{- range .Values.middlewares.localOnlyAllowlist.localIpCIDRs }}
      - "{{ . }}"
      {{- end }}
{{- end }}{{- end }}