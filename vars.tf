variable "kubectl_config_path" {
  default     = ""
  type        = string
}

data "external" "os" {
  working_dir = path.module
  program     = ["printf", "{\"os\": \"Linux\"}"]
}

locals {
  os                  = data.external.os.result.os
  kubectl_config_path = local.os == "Windows" ? "%USERPROFILE%\\.kube\\config" : "~/.kube/config"
}

# variable "minikube_ip" {
#   type = string
# }

variable "argocd_admin_pass" {
  type = string
  default = "runalsh123"
}

variable "local_domain" { 
  type = string
  default = "minikube.local"
}

variable "minikube" {
  type = bool
  default = false
}

variable "portainer" {
  type = bool
  default = false
}

variable "nexus" {
  type = bool
  default = false
}

variable "minio" {
  type = bool
  default = false
}

variable "localstack" {
  type = bool
  default = false
}

variable "harbor" {
  type = bool
  default = false
}

variable "gitlab" {
  type = bool
  default = false
}

variable "gitlabrunner" {
  type = bool
  default = false
}

variable "cloudnative-pg" {
  type = bool
  default = false
}

variable "cloudnative-pg-cluster" {
  type = bool
  default = false
}

variable "cert-manager" {
  type = bool
  default = false
}

variable "argocd" {
  type = bool
  default = false
}

variable "argocd_app_of_apps" {
  type = bool
  default = false
}

variable "argocd-rollouts" {
  type = bool
  default = false
}

variable "argocd-imageupdater" {
  type = bool
  default = false
}

variable "observability" {
  type = bool
  default = false
}

variable "terracurl_request" {
  type = bool
  default = false
}

variable "observability_promtail" {
  type = bool
  default = false
}

variable "observability_loki" {
  type = bool
  default = false
}

variable "observability_grafana" {
  type = bool
  default = false
}

variable "observability_kube-prometheus" {
  type = bool
  default = false
}

variable "github-runner-controller" {
  type = bool
  default = false
}

variable "vault" {
  type = bool
  default = false
}

variable "vault-consul" {
  type = bool
  default = false
}

variable "vault-local" {
  type = bool
  default = false
}

variable "csi-secret-storage" {
  type = bool
  default = false
}


variable "local-oci-repo" {
  type = bool
  default = false
}

variable "vault-k8s-tls" {
  type = bool
  default = false
}

variable "vault-k8s-server" {
  type = bool
  default = false
}

variable "vault-k8s-vaultparam" {
  type = object({
    nodes     = optional(number, 3)
    initialization = optional(object({
      shares    = number
      threshold = number
      }), {
      shares    = 5
      threshold = 3
    })
  })
}

variable "vault-docker-haproxy" {
  type = bool
  default = false
}
variable "vault-docker-haproxy-param" {
  type = object({
    ip_subnet = optional(string, "172.16.10.0/24")
    version   = optional(string, "1.16.1")
    base_port = optional(number, 8000)
    nodes     = optional(number, 3)
    initialization = optional(object({
      shares    = number
      threshold = number
      }), {
      shares    = 5
      threshold = 3
    })
  })
}

# variable "kubernetes" {
#   type = object({
#     enabled                  = optional(bool, true)
#     kms                      = optional(bool, false)
#     external_secrets_manager = optional(bool, true)
#     vault_secrets_operator   = optional(bool, true)
#     vault_agent_injector     = optional(bool, true)
#     csi                      = optional(bool, true)
#     cert_manager             = optional(bool, true)
#   })
# }

variable "argocd_projects" {
  description = "ArgoCD projects"
  type        = list(string)
  default     = ["non-default"]
}

variable "argocd_applications" {
  description = "ArgoCD applications"
  type = map(object({
    application_project   = string
    repoURL               = string
    targetRevision        = string
    path                  = string
    destination_namespace = string
  }))
}

variable "minikube_param" {
  type = object({
    nodes = optional(string, "1")
    kubernetes_version   = optional(string, "1.29.3")
    cluster_name = optional(string, "minikube")
    memory = optional(string, "5000")
    cpu = optional(string, "8")
    driver = optional(string, "docker")
  })
}