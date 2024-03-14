resource "kubernetes_namespace" "gitlabrunner-namespace" {
  metadata {
    name = "gitlabrunner"
  }
}

resource "helm_release" "gitlabrunner" {
  name             = "gitlabrunner"
  values           = [file("${path.module}/values/gitlabrunner.yaml")]
  depends_on       = [ kubernetes_namespace.gitlabrunner-namespace, resource.helm_release.gitlab ]
  repository       = "https://charts.gitlab.io/"
  chart            = "gitlab-runner"
  version          = "0.62.1"
  namespace        = "gitlabrunner"
  timeout = "600"
}