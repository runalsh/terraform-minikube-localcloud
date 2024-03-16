
# resource "kubernetes_namespace" "argocd-namespace" {
#   metadata {
#     name = "argocd"
#   }
# }

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "6.6.0"
  namespace        = "argocd"
  create_namespace = true
  force_update     = true
  values = [file("${path.module}/values/argocdvalues.yaml")]
}

# resource "kubectl_manifest" "argocd_dashboard" {
#   yaml_body = file("${path.module}/dashboards/argocd-grafana-dashboard.yaml")
#   depends_on = [
#     helm_release.argocd
#   ]
# }