# resource "kubernetes_namespace" "gitlab-namespace" {
#   metadata {
#     name = "gitlab"
#   }
# }

# resource "helm_release" "gitlab" {
#   name = "gitlab"
#   repository = "https://charts.gitlab.io/"
#   chart      = "gitlab"
#   version = "7.9.2"
#   namespace  = "gitlab"
  

#   values = [file("${path.module}/values/gitlab.yaml")]
#   depends_on = [ kubernetes_namespace.gitlab-namespace, resource.kubectl_manifest.gitlab-passwd-token] 
#   timeout = "600"
#   set {
#     name  = "timeout"
#     value = "600s"
#   }
# }

# resource "kubectl_manifest" "gitlab-passwd-token" {
#     count     = length(data.kubectl_filename_list.gitlab-passwd-token.matches)
#     yaml_body = file(element(data.kubectl_filename_list.gitlab-passwd-token.matches, count.index))
# }

# data "kubectl_filename_list" "gitlab-passwd-token" {
#     pattern = "./manifests/gitlab-passwd-token.yaml"
# }

# data "terracurl_request" "test" {
#   name   = "check"
#   url    = "http://gitlab.${local_domain}"
#   method = "GET"
#   skip_tls_verify = true
#   response_codes = [200]

#   max_retry      = 3
#   retry_interval = 10
# }