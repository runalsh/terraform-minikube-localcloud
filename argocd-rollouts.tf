

resource "helm_release" "argo-rollouts" {
  name = "argo-rollouts"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-rollouts"
  version          = "2.34.3" 
  namespace        = "argocd"
  values = [file("values/argo-rollouts.yaml")]
}