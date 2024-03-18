# provider "kind" {
# }

# resource "kind_cluster" "kind" {
#   name = "kind"
#   wait_for_ready = true
# #   kubeconfig_path = pathexpand(var.kube_config_path)
#   kind_config {
#     kind        = "Cluster"
#     api_version = "kind.x-k8s.io/v1alpha4"
#     node {
#           role = "control-plane"
#           image = "kindest/node:v1.29.2"
#           kubeadm_config_patches = [
#             <<-EOT
#               kind: InitConfiguration
#               nodeRegistration:
#                 kubeletExtraArgs:
#                   node-labels: "ingress-ready=true"
#             EOT
#           ]
#           extra_port_mappings {
#             container_port = 80
#             host_port      = 80
#             listen_address = "0.0.0.0"
#           }
#           extra_port_mappings {
#             container_port = 443
#             host_port      = 443
#             listen_address = "0.0.0.0"
#           }
#       }
#     node {
#       role = "worker"
#       image = "kindest/node:v1.29.2"
#     # }
#     # node {
#     #   role = "worker"
#     #   image = "kindest/node:v1.29.2"
#     # }
#   }
# }
# }

# provider "helm" {
#   kubernetes {
#     config_path = var.kubectl_config_path == "" ? local.kubectl_config_path : var.kubectl_config_path
#     config_context = "kind-${kind_cluster.kind.name}"
#   }
# }

# data "http" "kind_ingress_http" {
#   url = "https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml"
# }
# data "kubectl_file_documents" "nginx_yaml_files" {
#   content = data.http.kind_ingress_http.response_body
# }
# resource "kubectl_manifest" "nginx_manifest" {
#   provider = kubectl
#   for_each = data.kubectl_file_documents.nginx_yaml_files.manifests
#   yaml_body = each.value
#   wait = true
#   depends_on = [ kubernetes_namespace.nginx_namespace ]
# }
# resource "kubernetes_namespace" "nginx_namespace" {
#     metadata {
#       name = "ingress-nginx"
#     }
#     depends_on = [ kind_cluster.kind, data.kubectl_file_documents.nginx_yaml_files ]
# }

# #+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# variable "argocd_admin_pass" {
#   type = string
#   default = "admin"
# }

# variable "argocd_hostname" {
#   type = string
#   description = "the url of the argocd"
#   default = "argocd.kind.local"
# }

# resource "helm_release" "helm_argo" {
#   chart = "argo-cd"
#   repository = "https://argoproj.github.io/argo-helm"
#   name = "argocd"
#   version = "6.7.2"
#   namespace = "gitops"
#   create_namespace = true

#   set {
#     name = "server.ingress.enabled"
#     value = "true"
#   }
#   set {
#      name = "configs.params.server\\.insecure"
#      value = "true"
#   }
#   set {
#     name = "server.ingress.hosts"
#     value = "minikube.local"
#   }
#   set {
#     name = "configs.secret.argocdServerAdminPassword"
#     value = bcrypt(var.argocd_admin_pass)
#   }
#   depends_on = [ kubectl_manifest.nginx_manifest ]
# }

# // adding all the declartive argocd in the argo-apps folder to the cluster
# # resource "kubectl_manifest" "argocd_apps" {
# #   provider = kubectl
# #   for_each = fileset(path.module,"argo-apps/*.yaml")
# #   yaml_body = file("${path.module}/${each.key}")
# #   wait = true
# #   depends_on = [ helm_release.helm_argo ]
# # }