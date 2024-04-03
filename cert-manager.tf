resource "kubernetes_namespace" "cert-manager-namespace" {
  count = var.cert-manager ? 1 : 0  
  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "cert-manager" {
  name = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "1.14.4"
  namespace  = "cert-manager"
  count = var.cert-manager ? 1 : 0  
  // wait       = true
  // wait_for_jobs = true
  set {
    name  = "installCRDs"
    value = "true"
  }
}

# resource "kubernetes_secret" "ca-key-pair" {
#   metadata {
#     name      = "ca-key-pair"
#     namespace = "cert-manager"
#   }
#   data = {
#     "tls.crt" = file("./certs/cacerts.crt")
#     "tls.key" = file("./certs/cacerts.key")
#   }
#   type = "kubernetes.io/tls"
#   count = var.cert-manager ? 1 : 0  
# }

resource "time_sleep" "wait_x_seconds" {
  depends_on = [
    helm_release.cert-manager,
    # kubernetes_secret.ca-key-pair,
    kubernetes_namespace.cloudnative-pg-cluster-namespace 
  ]
  count = var.cert-manager ? 1 : 0  
  create_duration = "20s"
}

resource "kubectl_manifest" "cluster-issuer" {
  depends_on = [ 
    time_sleep.wait_x_seconds, 
    kubernetes_namespace.cloudnative-pg-cluster-namespace 
  ]
  yaml_body = file("${path.module}/values/cluster-issuer.yaml")
  count = var.cert-manager ? 1 : 0  
}