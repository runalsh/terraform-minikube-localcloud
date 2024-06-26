
provider "vault" {
  address = "http://127.0.0.1:8200"
  token = "hvs.IbmqmSNMN4fmFwfJCwIfLpHf" # from local-vault/cluster-keys.json # jq -r ".unseal_keys_b64 []" ./local-vault/cluster-keys.json
}

resource "null_resource" "vaultlocalrun" {
  count = var.local-vault ? 1 : 0  
  provisioner "local-exec" {
    when = create
    # command = "vault server -config=${path.module}/local-vault/config.hcl"
    command = "sc start Vault"
    interpreter = ["PowerShell", "-Command"]
  }
  depends_on = [ module.minikube ]
}

resource "null_resource" "vaultlocalunseal" {
  count = var.local-vault ? 1 : 0  
  provisioner "local-exec" {
    when = create
    command = "vault operator unseal -address http://127.0.0.1:8200 XMJgGblGtxMVwDnE0n05FNcxqnn/ZFeLVtW04jnU3nI="
    interpreter = ["PowerShell", "-Command"]
  }
  depends_on = [ module.minikube, null_resource.vaultlocalrun ]
}

resource "null_resource" "vaultlocalstop" {
  count = var.local-vault ? 1 : 0  
  provisioner "local-exec" {
    when       = destroy
    command = "sc stop Vault"
    interpreter = ["PowerShell", "-Command"]
  }
  depends_on = [ module.minikube ]
}

# cd F:\Temp\terraform-minikube-localcloud\local-vault
# vault server -config=F:/Temp/terraform-minikube-localcloud/local-vault/config.hcl

# $env:VAULT_ADDR="http://127.0.0.1:8200"
# $env:VAULT_TOKEN="hvs.IbmqmSNMN4fmFwfJCwIfLpHf"

# vault operator init -key-shares=1 -key-threshold=1 -address=http://127.0.0.1:8200 -format=json > cluster-keys.json
#  -tls-skip-verify 

# vault login -address http://127.0.0.1:8200
# vault status -address http://127.0.0.1:8200

# vault operator unseal -address http://127.0.0.1:8200 XMJgGblGtxMVwDnE0n05FNcxqnn/ZFeLVtW04jnU3nI=

# vault auth enable kubernetes
# vault secrets enable -path=secret kv-v2

# openssl genrsa > privkey.pem
# openssl req -new -x509 -key privkey.pem -config "F:\VB\Git\usr\ssl\openssl.cnf" > fullchain.pem
# $env:VAULT_SKIP_VERIFY








