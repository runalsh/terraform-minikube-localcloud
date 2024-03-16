

resource "helm_release" "argo-rollouts" {
  name = "argo-rollouts"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-rollouts"
  version          = "2.32.0" 
  namespace        = "argocd"
  values = [file("values/argo-rollouts.yaml")]
}