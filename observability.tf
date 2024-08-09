resource "kubernetes_namespace" "observability-namespace" {
  count = var.observability ? 1 : 0
  metadata {
    name = "observability"
  }
}

# Helm chart for Grafana
resource "helm_release" "grafana" {
  name             = "grafana"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "grafana"
  version          = "8.4.0"
  namespace        = "observability"
  count = var.observability_grafana ? 1 : 0

  values = [file("${path.module}/values/grafana.yaml")]
  depends_on = [ kubernetes_namespace.observability-namespace ]
}

# Helm chart for Loki
resource "helm_release" "loki" {
  name       = "loki"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki"
  version    = "6.10.0"
  namespace  = "observability"
  count = var.observability_loki ? 1 : 0

  values = [file("${path.module}/values/loki.yaml")]
  depends_on = [ kubernetes_namespace.observability-namespace ]
}

# Helm chart for promtail
resource "helm_release" "promtail" {
  name       = "promtail"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "promtail"
  version    = "6.16.3"
  namespace  = "observability"
  count = var.observability_promtail ? 1 : 0

  values = [file("${path.module}/values/promtail.yaml")]
  depends_on = [ kubernetes_namespace.observability-namespace ]
}

resource "helm_release" "kube-prometheus" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "61.7.0"
  namespace  = "observability"
  count = var.observability_kube-prometheus ? 1 : 0

  values = [file("${path.module}/values/prometheus.yaml")]
  # may be here https://github.com/tiagoangelototvs/testkube-playground/blob/main/prometheus.tf
  # values https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack
  depends_on = [ kubernetes_namespace.observability-namespace ]
}