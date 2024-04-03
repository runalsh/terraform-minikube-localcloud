# War is peace.
# Freedom is slavery.
# Ignorance is strength.

local_domain = "minikube.local"

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








