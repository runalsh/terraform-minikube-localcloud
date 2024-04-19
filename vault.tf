resource "kubernetes_namespace" "vault-namespace" {
  count = var.vault ? 1 : 0
  metadata {
    name = "vault"
  }
}

resource "helm_release" "vault" {
  name             = "vault"
  repository       = "https://registry.nationalcdn.ru//"
  chart            = "vault"
  version          = "0.28.0"
  # chart             = "charts/vault"
  # create_namespace = "true"
  # repository       = "https://helm.releases.hashicorp.com"
  # repository       = "https://hashicorp-helm.comcloud.xyz/"
  namespace        = "vault"
  
  count = var.vault ? 1 : 0
  depends_on = [ kubernetes_namespace.vault-namespace ]
  values = ["${file("${path.module}/values/vault.yaml")}"]
}
