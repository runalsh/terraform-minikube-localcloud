# resource "helm_release" "argocd-imageupdater" {
#   name = "argocd-imageupdater"

#   repository       = "https://argoproj.github.io/argo-helm"
#   chart            = "argocd-image-updater"
#   namespace        = "argocd"
#   version          = "0.8.4" # renovate: depName=argoproj/argo-helm extractVersion=^argocd-image-updater-(?<version>.+)$

#   values = [file("values/argocd-imageupdater.yaml")]
# }