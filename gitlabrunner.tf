resource "kubernetes_namespace" "gitlabrunner-namespace" {
  count = var.gitlabrunner ? 1 : 0
  metadata {
    name = "gitlabrunner"
  }
}

resource "helm_release" "gitlabrunner" {
  name             = "gitlabrunner"
  repository       = "https://charts.gitlab.io/"
  chart            = "gitlab-runner"
  version          = "0.63.0"
  count = var.gitlabrunner ? 1 : 0
  values           = [file("${path.module}/values/gitlabrunner.yaml")]
  depends_on       = [ kubernetes_namespace.gitlabrunner-namespace, resource.helm_release.gitlab ]

  namespace        = "gitlabrunner"
  timeout = "600"
}