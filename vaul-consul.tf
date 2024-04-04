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
  chart             = "vault-helm"
  version          = "0.27.0"
  namespace        = "vault"
  
  count = var.vault ? 1 : 0
  depends_on = [ kubernetes_namespace.vault-namespace ]
  # values = ["${file("${path.module}/values/vault.yaml")}"]
  values = ["${file("${path.module}/values/vault-raft.yaml")}"]
  provisioner "local-exec" {
    command = <<-EOT
    kubectl exec -n vault vault-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > cluster-keys.json
    EOT
    interpreter =  ["PowerShell", "-Command"] 
  }
}


    # jq -r ".unseal_keys_b64 []" cluster-keys.json
    # kubectl exec -n vault -ti vault-1 -- vault operator raft join http://vault-0.vault-internal:8200
    # kubectl exec -n vault -ti vault-2 -- vault operator raft join http://vault-0.vault-internal:8200
    # Z5l5D0ve3qBxRlTUSyAbTUAVrD/gLPVccaafDeTjYAs=

    # kubectl exec -n vault vault-0 -- vault operator unseal tgBIBURVW2t2eplpNe+O1cKinvMZ1fj6Tf8+49kTnCs=

