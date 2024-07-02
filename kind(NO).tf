provider "kind" {
}

resource "kind_cluster" "kind" {
  name = "kind"
  wait_for_ready = true
#   kubeconfig_path = pathexpand(locals.kubectl_config_path)
  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"
    # containerd_config_patches = [
    #   <<-TOML
    #     [plugins."io.containerd.grpc.v1.cri".registry]
    #       config_path = "${local.containerd_config_path}"
    #   TOML
    # ]
    node {
          role = "control-plane"
          image = "kindest/node:v1.30.2"
          kubeadm_config_patches = [
            <<-EOT
              kind: InitConfiguration
              nodeRegistration:
                kubeletExtraArgs:
                  node-labels: "ingress-ready=true"
            EOT
          ]
          extra_port_mappings {
            container_port = 80
            host_port      = 80
            listen_address = "0.0.0.0"
          }
          extra_port_mappings {
            container_port = 443
            host_port      = 443
            listen_address = "0.0.0.0"
          }
      }
    node {
      role = "worker"
      image = "kindest/node:v1.30.2"
    }
    # node {
    #   role = "worker"
    #   image = "kindest/node:v1.29.2"
    # }
  # }
}
}

# provider "helm" {
#   kubernetes {
#     config_path = var.kubectl_config_path == "" ? local.kubectl_config_path : var.kubectl_config_path
#     config_context = "kind-${kind_cluster.kind.name}"
#   }
# }

data "http" "kind_ingress_http" {
  url = "https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml"
}
data "kubectl_file_documents" "nginx_yaml_files" {
  content = data.http.kind_ingress_http.response_body
  depends_on = [ kind_cluster.kind ]
}
resource "kubectl_manifest" "nginx_manifest" {
  provider = kubectl
  for_each = data.kubectl_file_documents.nginx_yaml_files.manifests
  yaml_body = each.value
  wait = true
  depends_on = [ kubernetes_namespace.nginx_namespace, kind_cluster.kind ]
}
resource "kubernetes_namespace" "nginx_namespace" {
    metadata {
      name = "ingress-nginx"
    }
    depends_on = [ kind_cluster.kind, data.kubectl_file_documents.nginx_yaml_files ]
}

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
#     value = var.local_domain
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

# locals {
#   cilium_cert_secret = "cilium-https-cert"
# }

# resource "helm_release" "cilium" {
# #   count            = var.use_cilium ? 1 : 0
#   name             = "cilium"
#   repository       = "https://helm.cilium.io/"
#   chart            = "cilium"
#   version          = "1.15.6"
#   namespace        = "cilium"
#   create_namespace = true

# #   set {
# #     name  = "image.pullPolicy"
# #     value = "IfNotPresent"
# #   }

# #   set {
# #     name  = "ipam.mode"
# #     value = "kubernetes"
# #   }

# #   set {
# #     name  = "hubble.enabled"
# #     value = "true"
# #   }

# #   set {
# #     name  = "hubble.ui.enabled"
# #     value = "true"
# #   }

# #   set {
# #     name  = "hubble.relay.enabled"
# #     value = "true"
# #   }
# #   # Make sure `kind` has written the `kubeconfig` before we move forward
# #   # with installing helm.
# }

# module "cilium_tls" {
# #   count     = var.use_cilium ? 1 : 0
#   source    = "./modules/tls-cert"
#   namespace = helm_release.cilium[0].namespace
#   dns_names = [
#     "hubble.${var.base_domain}"
#   ]
# #   certs_path = var.certs_path
# }

# resource "kubectl_manifest" "hubble_grpc_service" {
# #   count     = var.use_cilium ? 1 : 0
#   yaml_body = <<YAML
# apiVersion: v1
# kind: Service
# metadata:
#   name: hubble-ui-grpc
#   namespace: ${helm_release.cilium.namespace}
# spec:
#   ports:
#   - name: grpc
#     port: 80
#     protocol: TCP
#     targetPort: 8090
#   selector:
#     k8s-app: hubble-ui
#   type: ClusterIP
# YAML
# }


# resource "kubectl_manifest" "hubble_ingress" {
# #   count     = var.use_cilium ? 1 : 0
#   yaml_body = <<YAML
# apiVersion: projectcontour.io/v1
# kind: HTTPProxy
# metadata:
#   name: hubble-ui
#   namespace: ${helm_release.cilium.namespace}
# spec:
#   virtualhost:
#     fqdn: hubble.${var.kind_local_domain}
#   routes:
#     - conditions:
#       - prefix: /api
#       enableWebsockets: true
#       services:
#         - name: hubble-ui-grpc
#           port: 80
#           protocol: h2c
#       timeoutPolicy:
#         response: 1h

#     - conditions:
#       - prefix: /
#       enableWebsockets: true
#       services:
#         - name: hubble-ui
#           port: 80
# YAML
# }

































































