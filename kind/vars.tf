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

variable "name" {
  type = string
}

variable "kind_local_domain" { 
  type = string
  default = "kind.local"
}