resource "kubernetes_namespace" "observability-namespace" {
  metadata {
    name = "observability"
  }
}

# Helm chart for Grafana
resource "helm_release" "grafana" {
  name             = "grafana"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "grafana"
  version          = "7.3.6"
  namespace        = "observability"

  values = [file("${path.module}/values/grafana.yaml")]
  depends_on = [ kubernetes_namespace.observability-namespace ]
}

# Helm chart for Loki
resource "helm_release" "loki" {
  name       = "loki"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki"
  version    = "5.43.6"
  namespace  = "observability"

  values = [file("${path.module}/values/loki.yaml")]
  depends_on = [ kubernetes_namespace.observability-namespace ]
}

# Helm chart for promtail
resource "helm_release" "promtail" {
  name       = "promtail"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "promtail"
  version    = "6.15.3"
  namespace  = "observability"

  values = [file("${path.module}/values/promtail.yaml")]
  depends_on = [ kubernetes_namespace.observability-namespace ]
}

resource "helm_release" "kube-prometheus" {
  name       = "kube-prometheus-stack"
  namespace  = "observability"
  version    = "57.0.2"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  values = [file("${path.module}/values/prometheus.yaml")]
  depends_on = [ kubernetes_namespace.observability-namespace ]
}