resource "kubernetes_namespace" "ydb-namespace" {
  count = var.ydb ? 1 : 0
  metadata {
    name = "ydb"
  }
}


resource "helm_release" "ydb_operator" {
  name       = "ydb-operator"
  repository = "https://charts.ydb.tech/"
  chart      = "ydb-operator"
  version    = "0.5.6"
  namespace  = "default"
  count = var.ydb ? 1 : 0
  depends_on = [resource.kubernetes_namespace.ydb-namespace]
  set {
    name  = "metrics.enabled"
    value = "true"
  }
}  

resource "kubectl_manifest" "ydb-storage" {
    yaml_body = file("${path.module}/manifests/ydb-storage.yml")
    depends_on = [ kubernetes_namespace.ydb-namespace ]
    count = var.ydb ? 1 : 0
}

resource "kubectl_manifest" "ydb-database" {
    yaml_body = file("${path.module}/manifests/ydb-database.yml")
    depends_on = [ kubernetes_namespace.ydb-namespace, resource.kubectl_manifest.ydb-storage ]
    count = var.ydb ? 1 : 0
}