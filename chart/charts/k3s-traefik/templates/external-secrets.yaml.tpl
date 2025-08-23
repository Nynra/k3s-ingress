{{- if .Values.enabled }}
{{- if .Values.dashboard.enabled }}{{- if .Values.dashboard.cert.externalSecret.enabled }}
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: traefik-dashboard-tls
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "0"
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
  secretStoreRef:
    kind: {{ .Values.dashboard.cert.externalSecret.secretStoreType | quote }}
    name: {{ .Values.dashboard.cert.externalSecret.secretStore | quote }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: tls.crt
      remoteRef:
        key: {{ .Values.dashboard.cert.externalSecret.secretName | quote }}
        property: tls_crt
    - secretKey: tls.key
      remoteRef:
        key: {{ .Values.dashboard.cert.externalSecret.secretName | quote }}
        property: tls_key
---
{{- end }}{{- end }}

{{- if .Values.crowdsecCredentials.externalSecret.enabled }}
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: crowdsec-bouncer-token
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "0"
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
  secretStoreRef:
    kind: {{ .Values.crowdsecCredentials.externalSecret.secretStoreType | quote }}
    name: {{ .Values.crowdsecCredentials.externalSecret.secretStore | quote }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: key
      remoteRef:
        key: {{ .Values.crowdsecCredentials.externalSecret.secretName | quote }}
        property: {{ .Values.crowdsecCredentials.externalSecret.bouncerTokenField | quote }}
---
{{- end }}

{{- end }}