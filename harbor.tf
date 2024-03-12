
resource "kubernetes_namespace" "harbor-namespace" {
  metadata {
    name = "harbor"
  }
}


resource "helm_release" "harbor" {
  name             = "harbor"
  repository       = "https://helm.goharbor.io"
  chart            = "harbor"
  namespace        = "harbor"

  values = [file("${path.module}/values/harbor.yaml")]
  depends_on = [ kubernetes_namespace.harbor-namespace ]
}


# provider "harbor" {
#   url      = "https://harbor.cluster.local"
#   username = "admin"
#   password = "runalsh123"
#   insecure = true
# }


# resource "harbor_project" "harbor" {
#     name = "harbor"
#     public                      = false               # (Optional) Default value is false
#     vulnerability_scanning      = false                # (Optional) Default value is true. Automatically scan images on push
#     enable_content_trust        = false                # (Optional) Default value is false. Deny unsigned images from being pulled (notary)
#     enable_content_trust_cosign = false               # (Optional) Default value is false. Deny unsigned images from being pulled (cosign)
# }

# resource "harbor_project" "dockerhubcache" {
#   name        = "dockerhubcache"
#   registry_id = harbor_registry.docker.registry_id
# }  

# resource "harbor_registry" "docker" {
#   provider_name = "docker-hub"
#   name          = "dockerhub"
#   endpoint_url  = "https://hub.docker.com"
# }

# resource "harbor_user" "runalsh" {
#   username  = "runalsh"
#   password  = "runalsh123"
#   full_name = "Captain Kube"
#   email     = "captain.kube@kubernetes.com"
# } 

