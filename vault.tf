resource "kubernetes_namespace" "vault-namespace" {
  count = var.vault ? 1 : 0
  metadata {
    name = "vault"
  }
}

resource "helm_release" "vault" {
  name             = "vault"
#   repository       = "https://helm.releases.hashicorp.com"
#   chart            = "vault"
  chart = "vault"
  version          = "0.27.0"
  create_namespace = "true"
  namespace        = "vault"
  
  count = var.vault ? 1 : 0
  depends_on = [ kubernetes_namespace.vault-namespace ]
  values = ["${file("${path.module}/values/vault.yaml")}"]
}
