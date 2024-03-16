# resource "kubernetes_namespace" "portainer-namespace" {
#   metadata {
#     name = "portainer"
#   }
# }

# resource "helm_release" "portainer" {
#   name             = "portainer"
#   repository       = "https://portainer.github.io/k8s/"
#   chart            = "portainer"
#   namespace        = "portainer"
#   lint             = false
#   cleanup_on_fail  = true
#   create_namespace = true
#   set {
#     name  = "ingress.enabled"
#     value = "true"
#   }
#   set {
#     name  = "ingress.hosts[0].host"
#     value = "portainer.minikube.local"
#   }
#   set {
#     name  = "ingress.hosts[0].paths[0].path"
#     value = "/"
#   }
# }