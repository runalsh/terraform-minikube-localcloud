
# resource "kubernetes_namespace" "argocd-namespace" {
#   metadata {
#     name = "argocd"
#   }
# }

# resource "helm_release" "argocd" {
#   name = "argocd"
#   repository       = "https://argoproj.github.io/argo-helm"
#   chart            = "argo-cd"
#   namespace        = "argocd"
#   create_namespace = true
#   version          = "6.6.0"  # renovate: depName=argoproj/argo-helm extractVersion=^argo-cd-(?<version>.+)$
#   force_update     = true
#   values = [file("${path.module}/values/argocdvalues.yaml")]
# }

# resource "kubectl_manifest" "argocd_dashboard" {
#   yaml_body = file("${path.module}/dashboards/argocd-grafana-dashboard.yaml")
#   depends_on = [
#     helm_release.argocd
#   ]
# }