

resource "helm_release" "argo-rollouts" {
  name = "argo-rollouts"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-rollouts"
  version          = "2.37.2" 
  namespace        = kubernetes_namespace.argocd-namespace
  values = [file("${path.module}/values/argo-rollouts.yaml")]
  count = var.argocd-rollouts ? 1 : 0
  depends_on = [
    helm_release.argocd,
    kubernetes_namespace.argocd-namespace
  ]
}