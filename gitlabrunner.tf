# resource "kubernetes_namespace" "gitlabrunner-namespace" {
#   metadata {
#     name = "gitlabrunner"
#   }
# }

# resource "helm_release" "gitlabrunner" {
#   name             = "gitlabrunner"
#   repository       = "https://charts.gitlab.io/"
#   chart            = "gitlab-runner"
#   version          = "0.62.1"
#   values           = [file("${path.module}/values/gitlabrunner.yaml")]
#   depends_on       = [ kubernetes_namespace.gitlabrunner-namespace, resource.helm_release.gitlab ]
  
#   namespace        = "gitlabrunner"
#   timeout = "600"
# }