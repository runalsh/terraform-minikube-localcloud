# resource "kubernetes_namespace" "localstack-namespace" {
#   metadata {
#     name = "localstack"
#   }
# }

# resource "kubectl_manifest" "localstack-cert" {
#   yaml_body = templatefile("${path.module}/values/localstack-cert.yaml", {
#     domain-name = "minikube.local"
#     namespace   = "localstack"
#   })
# }

# resource "helm_release" "localstack" {
#   name          = "localstack"
#   chart         = "localstack"
#   repository    = "https://localstack.github.io/helm-charts"
#   version       = "0.6.10"
#   namespace     = "localstack"
#   wait          = true
#   wait_for_jobs = true
#   values = [
#     templatefile("${path.module}/values/localstack-values.yaml", {
#       domain-name = "minikube.local"
#       namespace   = "localstack"
#       debug       = false
#     })
#   ]
#   depends_on = [ kubernetes_namespace.localstack-namespace, resource.kubectl_manifest.localstack-cert ]
# }