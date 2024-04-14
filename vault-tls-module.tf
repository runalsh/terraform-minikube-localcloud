module "vault-tls" {
  source = "./vault-tls"

  count = var.vault-k8s-tls ? 1 : 0  

  ca_cn   = "HashiCorp Vault CA"
  cert_cn = "Vault"

  ip_sans = ["127.0.0.1"]
  dns_sans = concat(
    ["vault.${var.local_domain}", "host.docker.internal"],
    [for v in range(0, var.vault-k8s-vaultparam.nodes) : format("vault-%02d", v + 1)]
  )
}

