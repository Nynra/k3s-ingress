{{ if .Values.enabled }}{{ if .Values.reflectedSecret.enabled }}
apiVersion: v1
kind: Secret
metadata:
  name: crowdsec-credentials
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "0"
    reflector.v1.k8s.emberstack.com/reflects: "{{ .Values.reflectedSecret.originNamespace }}/{{ .Values.reflectedSecret.originSecretName }}"
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
    {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if .Values.global.commonLabels }}
  labels:
    # Global labels
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
  {{- end }}
{{ end }}{{ end }}
