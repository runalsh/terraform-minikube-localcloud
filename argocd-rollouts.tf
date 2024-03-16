

# resource "helm_release" "argo-rollouts" {
#   name = "argo-rollouts"
#   repository       = "https://argoproj.github.io/argo-helm"
#   chart            = "argo-rollouts"
#   namespace        = "argocd"
#   version          = "2.32.0"  # renovate: depName=argoproj/argo-helm extractVersion=^argo-rollouts-(?<version>.+)$
#   values = [file("values/argo-rollouts.yaml")]
# }