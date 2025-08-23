{{- if .Values.enabled }}{{- if .Values.externalSecret.enabled }}
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: crowdsec-credentials
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-4"
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
    kind: {{ .Values.externalSecret.secretStoreType | quote }}
    name: {{ .Values.externalSecret.secretStore | quote }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: csLapiSecretKey
      remoteRef:
        key: {{ .Values.externalSecret.secretName | quote }}
        property: {{ .Values.externalSecret.properties.csLapiSecret | quote }}
    - secretKey: registrationTokenKey
      remoteRef:
        key: {{ .Values.externalSecret.secretName | quote }}
        property: {{ .Values.externalSecret.properties.registrationToken | quote }}
    - secretKey: bouncerTokenKey
      remoteRef:
        key: {{ .Values.externalSecret.secretName | quote }}
        property: {{ .Values.externalSecret.properties.bouncerToken | quote }}
    - secretKey: enrollKey
      remoteRef:
        key: {{ .Values.externalSecret.secretName | quote }}
        property: {{ .Values.externalSecret.properties.enrollKey | quote }}
{{- end }}{{- end }}