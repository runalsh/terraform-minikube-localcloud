resource "helm_release" "argocd-imageupdater" {
  name = "argocd-imageupdater"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argocd-image-updater"
  version          = "0.9.7"
  namespace        = kubernetes_namespace.argocd-namespace
  values = [file("${path.module}/values/argocd-imageupdater.yaml")]
  count = var.argocd-imageupdater ? 1 : 0
  depends_on = [
    helm_release.argocd,
    kubernetes_namespace.argocd-namespace
  ]
}