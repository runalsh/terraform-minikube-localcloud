# resource "helm_release" "argocd" {
#   name = "argocd"
#   repository       = "https://argoproj.github.io/argo-helm"
#   chart            = "argo-cd"
#   namespace        = "argocd"
#   create_namespace = true
#   version          = "6.6.0"
#   force_update     = true
#   values = [file("${path.module}/values/argocdvalues.yaml")]
# }
