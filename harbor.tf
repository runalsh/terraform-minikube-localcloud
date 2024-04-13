
resource "kubernetes_namespace" "harbor-namespace" {
  count = var.harbor ? 1 : 0
  metadata {
    name = "harbor"
  }
}


resource "helm_release" "harbor" {
  name             = "harbor"
  repository       = "https://helm.goharbor.io"
  chart            = "harbor"
  version          = "1.14.2"
  namespace        = "harbor"
  count = var.harbor ? 1 : 0

  values = [file("${path.module}/values/harbor.yaml")]
  depends_on = [ kubernetes_namespace.harbor-namespace ]
}

