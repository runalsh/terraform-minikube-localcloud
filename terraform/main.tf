terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "2.12.1"
    }
    minikube = {
      source = "scott-the-programmer/minikube"
      version = "0.3.10"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "%USERPROFILE%/.kube/config"
    config_context = "minikube"
  }
}

