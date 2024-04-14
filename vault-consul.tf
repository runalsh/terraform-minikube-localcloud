resource "kubernetes_namespace" "vault-consul-namespace" {
  count = var.vault-consul ? 1 : 0
  metadata {
    name = "vault-consul"
  }
}

resource "helm_release" "vault-consul-consul" {
  name             = "vault-consul-consul"
  repository       = "https://hashicorp-helm.comcloud.xyz/"
  chart            = "consul"
  version          = "1.4.1"
  # chart             = "charts/consul/charts/consul"
  # namespace        = "vault-consul"
  
  #   repository       = "https://helm.releases.hashicorp.com"
  
  count = var.vault-consul ? 1 : 0
  depends_on = [ kubernetes_namespace.vault-consul-namespace ]
  values = ["${file("${path.module}/values/vault-consul-consul.yaml")}"]
}


resource "helm_release" "vault-consul-vault" {
  name             = "vault-consul-vault"
  repository       = "https://hashicorp-helm.comcloud.xyz/"
  chart            = "vault"
  version          = "0.28.0"
  #   repository       = "https://helm.releases.hashicorp.com"
  # chart             = "charts/vault"
  # namespace        = "vault-consul"
  
  count = var.vault-consul ? 1 : 0
  depends_on = [ kubernetes_namespace.vault-namespace ]
  values = ["${file("${path.module}/values/vault-consul-vault.yaml")}"]
}


  # https://developer.hashicorp.com/vault/tutorials/kubernetes/kubernetes-minikube-consul
  # kubectl exec vault-consul-vault-0 -- vault operator init -key-shares=1 -key-threshold=1 -format=json > cluster-keys.json
  # jq -r ".unseal_keys_b64 []" cluster-keys.json
  # kubectl exec vault-consul-vault-0 -- vault operator unseal yHM7zmWAeH3L26wqYhTiHaeHa+Eaeif1yIeVC3moKOo=
  # kubectl exec vault-consul-vault-1 -- vault operator unseal yHM7zmWAeH3L26wqYhTiHaeHa+Eaeif1yIeVC3moKOo=
  # kubectl exec vault-consul-vault-2 -- vault operator unseal yHM7zmWAeH3L26wqYhTiHaeHa+Eaeif1yIeVC3moKOo=
#   cat cluster-keys.json | jq -r ".root_token"
#   kubectl exec --stdin=true --tty=true vault-consul-vault-0 -- /bin/sh
#   vault secrets enable -path=secret kv-v2
#   vault kv put secret/webapp/config username="static-user" password="static-password"
#   vault kv get secret/webapp/config
#   vault auth enable kubernetes
#   vault write auth/kubernetes/config kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443"
#   vault policy write webapp - <<EOF
# path "secret/data/webapp/config" {
#   capabilities = ["read"]
# }
# EOF

# vault write auth/kubernetes/role/webapp \
#         bound_service_account_names=vault \
#         bound_service_account_namespaces=default \
#         policies=webapp \
#         ttl=24h

# kubectl apply -f manifests/vault-consul-webapp.yml

# kubectl port-forward $(kubectl get pod -l app=webapp -o jsonpath="{.items[0].metadata.name}") 8080:8080
# curl http://localhost:8080

# vault secrets enable -path=internal kv-v2
# vault kv put internal/database/config username="db-readonly-username" password="db-secret-password"
# vault kv get internal/database/config
# vault policy write internal-app - <<EOF
# path "internal/data/database/config" {
#    capabilities = ["read"]
# }
# EOF

# kubectl create sa internal-app
# kubectl get serviceaccounts


# kubectl apply -f manifests/vault-consul-internal-app.yml 

# kubectl exec $(kubectl get pod -l app=orgchart -o jsonpath="{.items[0].metadata.name}") --container orgchart -- ls /vault/secrets

# kubectl patch deployment orgchart --patch "$(cat manifests/vault-consul-patch-inject-secrets.yaml)"

# kubectl exec $(kubectl get pod -l app=orgchart -o jsonpath="{.items[0].metadata.name}") --container vault-agent

# kubectl exec $(kubectl get pod -l app=orgchart -o jsonpath="{.items[0].metadata.name}") --container orgchart -- cat /vault/secrets/database-config.txt


