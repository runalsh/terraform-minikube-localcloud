terraform {
  required_version = ">= 1.1"
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "2.12.1"
    }
    minikube = {
      source = "scott-the-programmer/minikube"
      version = "0.3.10"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.27.0"
    }
    external = {
      source = "hashicorp/external"
      version = "2.3.3"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.2"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    harbor = {
      source = "goharbor/harbor"
      version = "3.10.8"
    }
    # terracurl = {
    #   source = "devops-rob/terracurl"
    #   version = "1.2.1"
    # }
  }
}

provider "helm" {
  kubernetes {
    config_path = var.kubectl_config_path == "" ? local.kubectl_config_path : var.kubectl_config_path
    config_context = minikube_cluster.cluster.cluster_name
  }
}

provider "kubernetes" {
  # host = minikube_cluster.docker.host
  # client_certificate     = minikube_cluster.docker.client_certificate
  # client_key             = minikube_cluster.docker.client_key
  # cluster_ca_certificate = minikube_cluster.docker.cluster_ca_certificate
  config_path = var.kubectl_config_path == "" ? local.kubectl_config_path : var.kubectl_config_path
}

# provider "terracurl" {}

