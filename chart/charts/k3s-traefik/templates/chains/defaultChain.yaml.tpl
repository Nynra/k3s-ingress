apiVersion: traefik.io/v1alpha1
kind: Middleware
metadata:
  name: traefik-default-chain
  namespace: {{ .Release.Namespace | quote }}
spec:
  chain:
    middlewares:
    {{- if .Values.middlewares.rateLimiting.enabled }}{{- if .Values.middlewares.rateLimiting.inDefaultChain }}
    - name: ratelimit
    {{- end }}{{- end }}
    - name: https-only
    - name: default-headers
    {{- if .Values.middlewares.crowdsecBouncer.enabled }}{{- if .Values.middlewares.crowdsecBouncer.inDefaultChain }}
    - name: crowdsec-bouncer
    {{- end }}{{- end }}
    {{- if .Values.middlewares.localOnlyAllowlist.enabled }}{{- if .Values.middlewares.localOnlyAllowlist.inDefaultChain }}
    - name: lan-only
    {{- end }}{{- end }}
    {{- if .Values.middlewares.autheliaForwardAuth.enabled }}{{- if .Values.middlewares.autheliaForwardAuth.inDefaultChain }}
    - name: authelia-forward-auth
    {{- end }}{{- end }}