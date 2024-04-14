# War is peace.
# Freedom is slavery.
# Ignorance is strength.

local_domain = "minikube.local"

minikube = true
minikube_param = {
    nodes =  "1"
    kubernetes_version   = "1.29.3"
    cluster_name = "minikube"
    memory = "6000"
    cpu = "12"
    driver = "docker" #hyperv
}

portainer = false
nexus = false
minio = false
localstack = false
harbor = false
gitlab = false
gitlabrunner = false
cloudnative-pg = false
cloudnative-pg-cluster = false
cert-manager = false
argocd = false
argocd_app_of_apps = false
argocd-rollouts = false
argocd-imageupdater = false
terracurl_request = false
github-runner-controller = false
vault = false
vault-consul = false
csi-secret-storage = false
local-vault = false
local-oci-repo = false
local-portainer = false
kubeapps = true

# vault k8s pure
vault-k8s-tls = false
vault-k8s-server = false

vault-k8s-vaultparam = {
  nodes = 1
  initialization = {
    shares    = 1
    threshold = 1
  }
}

# VAULT DOCKER WITH HAPROXY
vault-docker-haproxy = false
vault-docker-haproxy-param = {
  nodes = 3
  ip_subnet = "172.16.10.0/24"
  #version = "1.16.1"
  version = "latest"
  base_port = 8000
  initialization = {
    shares    = 5
    threshold = 3
  }
}

observability = false
observability_promtail = false
observability_loki = false
observability_grafana = false
observability_kube-prometheus  = false

argocd_projects = [
  "non-default"
]

argocd_applications = {
  app-of-apps = {
    application_project   = "non-default"
    repoURL               = "https://github.com/runalsh/terraform-minikube-localcloud.git"
    targetRevision        = "HEAD"
    path                  = "apps/dev"
    destination_namespace = "argocd-app-of-apps"
  }
}

# kubernetes = {
#   enabled = true
#   kms = true
#   external_secrets_manager = true
#   vault_secrets_operator = true
#   csi = true
#   cert_manager = true
#   vault_agent_injector = true
# }






