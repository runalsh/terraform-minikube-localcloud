# resource "kubernetes_namespace" "cloudnative-pg-cluster-namespace" {
#   metadata {
#     name = "cloudnative-pg-cluster"
#   }
# }

# resource "helm_release" "cloudnative-pg-cluster" {
#   name             = "cnpg"
#   repository       = "https://cloudnative-pg.github.io/charts"
#   chart            = "cluster"
#   version          = "0.0.6"
#   namespace        = "cloudnative-pg-cluster"

#   values = [file("${path.module}/values/cloudnative-pg-cluster.yaml")]
#   depends_on = [ kubernetes_namespace.cloudnative-pg-cluster-namespace ]
# }
