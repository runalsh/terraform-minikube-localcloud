# resource "helm_release" "portainer" {
#   name             = "portainer"
#   repository       = "https://portainer.github.io/k8s/"
#   chart            = "portainer"
#   namespace        = "portainer"
#   lint             = false
#   cleanup_on_fail  = true
#   create_namespace = true

#   values = [yamlencode({
#     service = { type = "ClusterIP" }

#   })]
# }