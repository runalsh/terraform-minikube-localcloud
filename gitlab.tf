resource "kubernetes_namespace" "gitlab-namespace" {
  count = var.gitlabrunner ? 1 : 0
  metadata {
    name = "gitlab"
  }
}

resource "helm_release" "gitlab" {
  name = "gitlab"
  repository = "https://charts.gitlab.io/"
  chart      = "gitlab"
  version = "8.1.1"
  namespace  = "gitlab"
  count = var.gitlabrunner ? 1 : 0
  values = [file("${path.module}/values/gitlab.yaml")]
  depends_on = [ kubernetes_namespace.gitlab-namespace, resource.kubectl_manifest.gitlab-passwd-token] 
  timeout = "600"
  set {
    name  = "timeout"
    value = "600s"
  }
}

resource "kubectl_manifest" "gitlab-passwd-token" {
    yaml_body = file("${path.module}/manifests/gitlabpasswdtoken.yaml")
    # count     = length(data.kubectl_filename_list.gitlab-passwd-token.matches)
    # yaml_body = file(element(data.kubectl_filename_list.gitlab-passwd-token.matches, count.index))
    depends_on = [ kubernetes_namespace.gitlab-namespace ]
    count = var.gitlabrunner ? 1 : 0
}

# data "kubectl_filename_list" "gitlab-passwd-token" {
#     pattern = "./manifests/gitlab-passwd-token.yaml"
# }
