



resource "kubernetes_namespace" "ydb-namespace" {
  metadata {
    name = "ydb"
  }
}

resource "helm_release" "ydb_operator" {
  name       = "ydb-operator"
  repository = "https://charts.ydb.tech/"
  chart      = "ydb-operator"
  version    = "0.5.20"
  namespace  = kubernetes_namespace.ydb-namespace.metadata[0].name
  depends_on = [resource.kubernetes_namespace.ydb-namespace]
  set {
    name  = "metrics.enabled"
    value = "true"
  }
}

resource "kubectl_manifest" "ydb-storage" {
    yaml_body = templatefile("${path.module}/../manifests/ydb-storage.yml", {
      namespace   = kubernetes_namespace.ydb-namespace.metadata[0].name
  })
    depends_on = [kubernetes_namespace.ydb-namespace]
}

resource "kubectl_manifest" "ydb-database" {
    yaml_body = templatefile("${path.module}/../manifests/ydb-database.yml", {
      namespace   = kubernetes_namespace.ydb-namespace.metadata[0].name
  })
    depends_on = [kubernetes_namespace.ydb-namespace, resource.kubectl_manifest.ydb-storage]
}

# https://github.com/ydb-platform/ydb/tree/main/ydb/deploy/helm/ydb-prometheus

# resource "helm_release" "ydb_prometheus" {
#   name       = "ydb-prometheus"
#   repository = "charts"
#   chart      = "ydb-prometheus"
#   version    = "0.1.0"
#   namespace  = kubernetes_namespace.ydb-namespace.metadata[0].name
#   count = var.ydb ? 1 : 0
#   depends_on = [resource.kubernetes_namespace.ydb-namespace, resource.helm_release.ydb-kube-prometheus]
# }

  # values\prometheus-ydb.yaml

resource "helm_release" "ydb-kube-prometheus" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "61.7.0"
  namespace  = kubernetes_namespace.ydb-namespace.metadata[0].name

  values = [file("${path.module}/../values/prometheus-ydb.yaml")]
  # may be here https://github.com/tiagoangelototvs/testkube-playground/blob/main/prometheus.tf
  # values https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack
  depends_on = [ resource.kubernetes_namespace.ydb-namespace]
}  