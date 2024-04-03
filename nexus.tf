
resource "kubernetes_namespace" "nexus-namespace" {
  count = var.nexus ? 1 : 0
  metadata {
    name = "nexus"
  }
}


resource "helm_release" "nexus" {
  name             = "nexus"
  repository       = "https://sonatype.github.io/helm3-charts/"
  chart            = "nexus-repository-manager"
  version          = "64.2.0"
  namespace        = "nexus"
  count = var.nexus ? 1 : 0

  values = [file("${path.module}/values/nexus.yaml")]
  depends_on = [ kubernetes_namespace.nexus-namespace ]
}
