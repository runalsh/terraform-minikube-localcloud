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

variable "local_domain" { #${local_domain}
  type = string
  default = "minikube.local"
}
