{{/*
Expand the name of the chart.
*/}}
{{- define "resourceName" -}}
{{- printf "%s" $.Values.global.projectName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "fullResourceName" -}}
{{- printf "%s-%s" .projectName .serviceName }}
{{- end }}

{{- define "argo-deployment-strategy" -}}
{{- if eq .strategy "argo" }}
true
{{- else -}}
false
{{- end }}
{{- end }}

{{- define "labels" -}}
app.kubernetes.io/instance: {{ .module | lower | quote }}
app.kubernetes.io/name: {{ .global.projectName | quote }}
{{- end }}

{{- define "deployment-image" }}
{{- $imageRegistry :=  default "docker.io" .image.registry .global.image.registry }}
{{- $imageRepository := default "" .image.repository .global.image.repository }}
{{- $imageSubPath := default "" .image.subpath .global.image.subpath }}
{{- $imageTag := default "latest" .image.tag .global.image.tag }}
{{- $imagePullPolicy := .image.pullPolicy }}
{{- $globalPullPolicy := .global.image.pullPolicy }}
{{- $pullPolicyParams := (dict "imageTag" $imageTag "imagePullPolicy" $imagePullPolicy "globalPullPolicy" $globalPullPolicy) }}
image: {{ printf "%s/%s/%s:%s" $imageRegistry $imageRepository $imageSubPath $imageTag | replace "//" "/" | replace "/:" ":" }}
imagePullPolicy: {{ include "imagePullPolicy" $pullPolicyParams }}
{{ end -}}

{{- define "prometheus-metrics" -}}
prometheus.io/scrape: "true"
prometheus.io/path: /metrics
prometheus.io/port: "8090"
{{- end }}

{{- define "imagePullPolicy" -}}
{{- $imageTag := .imageTag -}}
{{- $imagePullPolicy := .imagePullPolicy -}}
{{- $globalImagePullPolicy := .globalPullPolicy -}}
{{- if eq $imageTag "latest" -}}
"Always"
{{- else }}
{{- default "IfNotPresent" $imagePullPolicy $globalImagePullPolicy -}}
{{- end }}
{{- end }}


{{/*
Selector labels
*/}}
{{- define "..selectorLabels" -}}
app.kubernetes.io/name: {{ include "resourceName" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
