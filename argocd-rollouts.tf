

resource "helm_release" "argo-rollouts" {
  name = "argo-rollouts"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-rollouts"
  version          = "2.35.1" 
  namespace        = "argocd"
  values = [file("values/argo-rollouts.yaml")]
  count = var.argocd-rollouts ? 1 : 0
}