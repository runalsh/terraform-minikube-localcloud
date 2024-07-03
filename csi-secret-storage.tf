resource "kubernetes_namespace" "csi-secret-storage-namespace" {
  count = var.csi-secret-storage ? 1 : 0
  metadata {
    name = "csi-secret-storage"
  }
}

resource "helm_release" "secret_storage_csi_driver" {
  name       = "secrets-store-csi-driver"
  repository = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart      = "secrets-store-csi-driver"
  version    = "1.4.4"
  namespace  = "csi-secret-storage"
  atomic     = true
  count = var.csi-secret-storage ? 1 : 0
  set {
    name  = "linux.tolerations[0].operator"
    value = "Exists"
  }
  set {
    name  = "linux.tolerations[0].effect"
    value = "NoSchedule"
  }
}

# https://habr.com/ru/companies/ru_mts/articles/716624/
# https://secrets-store-csi-driver.sigs.k8s.io/getting-started/installation
# https://habr.com/ru/companies/nixys/articles/660455/