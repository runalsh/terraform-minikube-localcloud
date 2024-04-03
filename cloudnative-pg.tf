resource "kubernetes_namespace" "cloudnative-pg-namespace" {
  count = var.cloudnative-pg ? 1 : 0  
  metadata {
    name = "cloudnative-pg"
  }
}

resource "helm_release" "cloudnative-pg" {
  name             = "cnpg"
  repository       = "https://cloudnative-pg.github.io/charts"
  chart            = "cloudnative-pg"
  version          = "0.20.2"
  namespace        = "cloudnative-pg"
  count = var.cloudnative-pg ? 1 : 0
  values = [file("${path.module}/values/cloudnative-pg.yaml")]
  depends_on = [ kubernetes_namespace.cloudnative-pg-namespace ]
}
