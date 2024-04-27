
locals {
  knative = {
    operator = { version = "1.13.0" }
    eventing = { version = "1.13.0" }
    serving  = { version = "1.13.0" }
  }
}

resource "kubernetes_namespace" "knative" {
  metadata {
    name = "knative-operator"
  }
}

resource "kubernetes_namespace" "knative_eventing" {
  metadata { 
    name = "knative-eventing" 
    }
}

resource "kubernetes_namespace" "knative_serving" {
  metadata { 
    name = "knative-serving" 
    }
}

data "kustomization_overlay" "knative_operator" {
  resources = ["https://github.com/knative/operator/releases/download/knative-v${local.knative.operator.version}/operator.yaml"]
  namespace = "knative-operator"
}

resource "kustomization_resource" "knative_operator" {
  for_each = data.kustomization_overlay.knative_operator.ids
  manifest = data.kustomization_overlay.knative_operator.manifests[each.value]

  depends_on = [kubernetes_namespace.knative]
}

resource "kustomization_resource" "knative_eventing" {
  manifest = jsonencode({
    "apiVersion" = "operator.knative.dev/v1beta1"
    "kind"       = "KnativeEventing"
    "metadata"   = {
      "name"      = "knative-eventing"
      "namespace" = kubernetes_namespace.knative_eventing.metadata[0].name
    }
    "spec"       = { "version" = local.knative.eventing.version }
  })

  depends_on = [kustomization_resource.knative_operator]
}

resource "kustomization_resource" "knative_serving" {
  manifest = jsonencode({
    "apiVersion" = "operator.knative.dev/v1beta1"
    "kind"       = "KnativeServing"
    "metadata"   = {
      "name"      = "knative-serving"
      "namespace" = kubernetes_namespace.knative_serving.metadata[0].name
    }
    "spec"       = { 
      "version" = local.knative.serving.version
      "ingress" = {
        "kourier" = {
          "enabled" = true
        }
      }
      "config" = {
        "network" = {
          "ingress-class" = "kourier.ingress.networking.knative.dev"
        }
      }
    }
  })

  depends_on = [kustomization_resource.knative_operator]
}

# spec:
#   # ...
#   ingress:
#     kourier:
#       enabled: true
#   config:
#     network:
#       ingress-class: "kourier.ingress.networking.knative.dev"

data "http" "knative_serving_dns" {
  url = "https://github.com/knative/serving/releases/download/knative-v${local.knative.serving.version}/serving-default-domain.yaml"
}

data "kubectl_file_documents" "knative_serving_dns" {
  content = data.http.knative_serving_dns.body
}

resource "kubectl_manifest" "knative_serving_dns" {
  for_each  = data.kubectl_file_documents.knative_serving_dns.manifests
  yaml_body = each.value
  depends_on = [kustomization_resource.knative_operator,kustomization_resource.knative_eventing,kustomization_resource.knative_eventing]
}

data "http" "knative_serving_kourier" {
  url = "https://github.com/knative/net-kourier/releases/latest/download/kourier.yaml"
}

data "kubectl_file_documents" "knative_serving_kourier" {
  content = data.http.knative_serving_kourier.body
}

resource "kubectl_manifest" "knative_serving_kourier" {
  for_each  = data.kubectl_file_documents.knative_serving_kourier.manifests
  yaml_body = each.value
  depends_on = [kustomization_resource.knative_operator,kustomization_resource.knative_eventing,kustomization_resource.knative_eventing]
}
