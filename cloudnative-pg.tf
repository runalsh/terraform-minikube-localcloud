# resource "kubernetes_namespace" "cloudnative-pg-namespace" {
#   metadata {
#     name = "cloudnative-pg"
#   }
# }

# resource "helm_release" "cloudnative-pg" {
#   name             = "cnpg"
#   repository       = "https://cloudnative-pg.github.io/charts"
#   chart            = "cloudnative-pg"
#   version          = "0.20.2"
#   namespace        = "cloudnative-pg"

#   values = [file("${path.module}/values/cloudnative-pg.yaml")]
#   depends_on = [ kubernetes_namespace.cloudnative-pg-namespace ]
# }
