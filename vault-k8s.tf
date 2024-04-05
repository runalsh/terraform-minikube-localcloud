module "tls" {
  source = "./vault-k8s/tls-init"

  count = var.vault-k8s-tls ? 1 : 0  

  ca_cn   = "HashiCorp Vault Playground CA"
  cert_cn = "Vault"

  ip_sans = ["127.0.0.1"]
  dns_sans = concat(
    ["minikube.local", "host.docker.internal"],
    [for v in range(0, var.vault-k8s-vaultparam.nodes) : format("vault-%02d", v + 1)]
  )
}

# module "vault" {
#   source = "./vault-k8s/vault-server"

#   count = var.vault-k8s-server ? 1 : 0  

#   vault_nodes   = var.vault-k8s-vaultparam.nodes
#   ip_subnet     = var.vault-k8s-vaultparam.ip_subnet
#   vault_version = var.vault-k8s-vaultparam.version

#   initialization = {
#     shares    = var.vault-k8s-vaultparam.initialization.shares
#     threshold = var.vault-k8s-vaultparam.initialization.threshold
#   }

#   depends_on = [module.tls]
# }
