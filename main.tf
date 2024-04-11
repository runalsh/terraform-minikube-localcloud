terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
  required_version = ">= 1.6"
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "2.13.0"
    }
    minikube = {
      source = "scott-the-programmer/minikube"
      version = "0.3.10"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.28.1"
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
    kind = {
      source = "tehcyx/kind"
      version = "0.4.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.4.2"
    }
    terracurl = {
      source = "devops-rob/terracurl"
      version = "1.2.1"
    }
    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.5.1"
    }
    vault = {
      source = "hashicorp/vault"
      version = "4.2.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
    k3d = {
      source = "pvotal-tech/k3d"
      version = "0.0.7"
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
  }
}