{{ if .Values.enabled }}

{{ if .Values.dashboard.enabled }}{{ if .Values.dashboard.cert.reflectedSecret.enabled }}
apiVersion: v1
kind: Secret
metadata:
  name: traefik-dashboard-tls
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "0"
    reflector.v1.k8s.emberstack.com/reflects: "{{ .Values.dashboard.cert.reflectedSecret.originNamespace }}/{{ .Values.dashboard.cert.reflectedSecret.originSecretName }}"
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
      {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if .Values.global.commonLabels }}
  labels:
    # Global labels
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
  {{- end }}
---
{{ end }}{{ end }}

{{ if .Values.crowdsecCredentials.reflectedSecret.enabled }}
apiVersion: v1
kind: Secret
metadata:
  name: crowdsec-bouncer-token
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "0"
    reflector.v1.k8s.emberstack.com/reflects: "{{ .Values.crowdsecCredentials.reflectedSecret.originNamespace }}/{{ .Values.crowdsecCredentials.reflectedSecret.originSecretName }}"
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
    {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if .Values.global.commonLabels }}
  labels:
    # Global labels
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
  {{- end }}
data:
  key: {{ .Values.crowdsecCredentials.reflectedSecret.originSecretName | quote }}
---
{{ end }}

{{ end }}