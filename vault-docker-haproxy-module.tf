module "vault-docker-haproxy" {
  source = "./vault-docker-haproxy"
  
  count = var.vault-docker-haproxy ? 1 : 0

  vault_nodes   = var.vault-docker-haproxy-param.nodes
  ip_subnet     = var.vault-docker-haproxy-param.ip_subnet
  vault_version = var.vault-docker-haproxy-param.version

  initialization = {
    shares    = var.vault-docker-haproxy-param.initialization.shares
    threshold = var.vault-docker-haproxy-param.initialization.threshold
  }

  depends_on = [module.vault-tls]
}

# vault status -address https://127.0.0.1 -ca-cert ./vault-tls/output/ca.crt  

# terraform apply -target module.vault-tls -target module.vault-docker-haproxy --auto-approve