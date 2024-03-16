resource "helm_release" "argocd-imageupdater" {
  name = "argocd-imageupdater"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argocd-image-updater"
  version          = "0.8.4"
  namespace        = "argocd"
  values = [file("values/argocd-imageupdater.yaml")]
}