terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "2.12.1"
    }

  }
}

provider "helm" {
  kubernetes {
    config_path = "%USERPROFILE%/.kube/config"
    config_context = "minikube"
  }
}

