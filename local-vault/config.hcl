storage "raft" {
  path    = "F:/Temp/terraform-minikube-localcloud/local-vault/vault/data"
  node_id = "vault"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  // tls_disable = "false"
  tls_cert_file = "F:/Temp/terraform-minikube-localcloud/local-vault/fullchain.pem"
  tls_key_file  = "F:/Temp/terraform-minikube-localcloud/local-vault/privkey.pem"
}


disable_mlock = true
api_addr = "http://127.0.0.1:8200"
cluster_addr = "https://127.0.0.1:8201"
ui = true