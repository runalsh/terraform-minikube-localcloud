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
