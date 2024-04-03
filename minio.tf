resource "kubernetes_namespace" "minio-namespace" {
  count = var.minio ? 1 : 0
  metadata {
    name = "minio"
  }
}


resource "helm_release" "minio_cluster" {
  name       = "minio-cluster"
  repository = "https://charts.min.io"
  chart      = "minio"
  version    = "13.8.4"
  namespace  = "minio"
  count = var.minio ? 1 : 0
  values = [file("${path.module}/values/minio.yaml")]
  depends_on = [resource.kubernetes_namespace.minio-namespace]
  set {
    name  = "buckets[0].name"
    value = "lake"
  }

  set {
    name  = "buckets[0].policy"
    value = "public"
  }

  set {
    name  = "buckets[0].purge"
    value = "true"
  }
}  