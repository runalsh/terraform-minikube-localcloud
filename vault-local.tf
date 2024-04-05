
resource "null_resource" "vaultlocalrun" {
  provisioner "local-exec" {
    command = "vault server -config=${path.module}/vault-local/config.hcl"
    interpreter = ["PowerShell", "-Command"]
  }
  depends_on = [ resource.minikube_cluster.cluster ]
}

resource "null_resource" "vaultlocalunseal" {
  provisioner "local-exec" {
    command = "vault operator unseal -address http://127.0.0.1:8200 XMJgGblGtxMVwDnE0n05FNcxqnn/ZFeLVtW04jnU3nI="
    interpreter = ["PowerShell", "-Command"]
  }
  depends_on = [ resource.minikube_cluster.cluster, null_resource.vaultlocalrun ]
}


# cd F:\Temp\terraform-minikube-localcloud\vault-local
# vault server -config=F:/Temp/terraform-minikube-localcloud/vault-local/config.hcl

# $env:VAULT_ADDR="http://127.0.0.1:8200"
# $env:VAULT_TOKEN="hvs.IbmqmSNMN4fmFwfJCwIfLpHf"

# vault operator init -key-shares=1 -key-threshold=1 -address=http://127.0.0.1:8200 -format=json > cluster-keys.json

# vault login -address http://127.0.0.1:8200
# vault status -address http://127.0.0.1:8200

# vault operator unseal -address http://127.0.0.1:8200 XMJgGblGtxMVwDnE0n05FNcxqnn/ZFeLVtW04jnU3nI=

