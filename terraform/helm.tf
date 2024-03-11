resource "helm_release" "argocd" {
  name = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "6.6.0"
  values = [file("argocdvalues.yaml")]
}

resource "helm_release" "kubernetes-dashboard" {
  name = "kubernetes-dashboard"
  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"
  namespace  = "default"
  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
  set {
    name  = "protocolHttp"
    value = "true"
  }
  set {
    name  = "service.externalPort"
    value = 80
  }
  set {
    name  = "replicaCount"
    value = 2
  }
  set {
    name  = "rbac.clusterReadOnlyRole"
    value = "true"
  }
}