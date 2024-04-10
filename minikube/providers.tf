terraform {
  required_version = ">= 1.6.0"

  required_providers {
    minikube = {
      source = "scott-the-programmer/minikube"
      version = "0.3.10"
    }
    local = {
      source = "hashicorp/local"
      version = "2.5.1"
    }
  }
}
