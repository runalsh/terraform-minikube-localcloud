terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
  required_version = ">= 1.6"
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "3.3.0"
    }
    minikube = {
      source = "scott-the-programmer/minikube"
      version = "0.7.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "3.2.0"
    }
    external = {
      source = "hashicorp/external"
      version = "2.4.0"
    }
    null = {
      source = "hashicorp/null"
      version = "3.3.0"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.19.0"
    }
    kind = {
      source = "tehcyx/kind"
      version = "0.11.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.6.0"
    }
    terracurl = {
      source = "devops-rob/terracurl"
      version = "2.11.0"
    }
    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.9.0"
    }
    vault = {
      source = "hashicorp/vault"
      version = "5.11.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.4.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "4.6.0"
    }
    k3d = {
      source = "pvotal-tech/k3d"
      version = "0.0.7"
    }
    kustomization = {
      source = "kbst/kustomization"
      version = "0.9.6"
    }
  }
}

provider "kubernetes" {
  # host = minikube_cluster.docker.host
  # client_certificate     = minikube_cluster.docker.client_certificate
  # client_key             = minikube_cluster.docker.client_key
  # cluster_ca_certificate = minikube_cluster.docker.cluster_ca_certificate
  config_path = var.kubectl_config_path == "" ? local.kubectl_config_path : var.kubectl_config_path
}

provider "terracurl" {}

provider "helm" {
  kubernetes {
    config_path = var.kubectl_config_path == "" ? local.kubectl_config_path : var.kubectl_config_path
    # config_context = module.minikube.minikube_name
    config_context = var.minikube_param.cluster_name
    # config_context = "kind-kind"
    # config_context = "kind-${var.kind_cluster_name}"
    # config_context = var.minikube ? var.minikube_name : "kind-${var.kind_cluster_name}"
  }
}

# provider "minikube" {
#   kubernetes_version = var.minikube_param.kubernetes_version
# }

# provider "kustomization" {
#   kubeconfig_path = var.kubectl_config_path == "" ? local.kubectl_config_path : var.kubectl_config_path
#   # kubeconfig_path = "C:/Users/ilnur/.kube/config"

# }