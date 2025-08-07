{{- if .Values.enabled }}{{- if .Values.crowdsecCredentials.enabled }}
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: crowdsec-bouncer-token
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-10"
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
    kind: {{ .Values.crowdsecCredentials.secretStoreType | quote }}
    name: {{ .Values.crowdsecCredentials.secretStore | quote }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: key
      remoteRef:
        key: {{ .Values.crowdsecCredentials.secretName | quote }}
        property: {{ .Values.crowdsecCredentials.properties.bouncerToken | quote }}
{{- end }}{{- end }}