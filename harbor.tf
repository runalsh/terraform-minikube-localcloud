
resource "kubernetes_namespace" "harbor-namespace" {
  metadata {
    name = "harbor"
  }
}


resource "helm_release" "harbor" {
  name             = "harbor"
  repository       = "https://helm.goharbor.io"
  chart            = "harbor"
  namespace        = "harbor"

  values = [file("${path.module}/values/harbor.yaml")]
  depends_on = [ kubernetes_namespace.harbor-namespace ]
}

