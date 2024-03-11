# resource "helm_release" "argocd" {
#   name = "argocd"
#   repository       = "https://argoproj.github.io/argo-helm"
#   chart            = "argo-cd"
#   namespace        = "argocd"
#   create_namespace = true
#   version          = "6.6.0"
#   values = [file("argocdvalues.yaml")]
# }
