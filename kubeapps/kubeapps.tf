resource "kubernetes_namespace" "kubeapps" {
  metadata {
    name = "kubeapps"
  }
}

resource "helm_release" "kubeapps" {
  name       = "kubeapps"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kubeapps"
  version    = "15.0.2"
  # chart    = "https://charts.bitnami.com/bitnami/kubeapps-15.0.2.tgz"
  namespace  = kubernetes_namespace.kubeapps.metadata[0].name
 
  values = [templatefile("${path.module}/../values/kubeapps.yaml", {
    kubeapps_domain = "kubeapp.${var.local_domain}"
  })]
}

resource "kubernetes_service_account" "kubeapps_operator" {
  metadata {
    name = "kubeapps-operator"
    namespace = "default"
  }
}

resource "kubernetes_cluster_role_binding" "kubeapps_operator" {
  depends_on = [ helm_release.kubeapps ]

  metadata {
    name = "kubeapps-operator"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "kubeapps-operator"
    namespace = "default" #kubernetes_namespace.kubeapps.metadata[0].name
  }
}

resource "kubernetes_secret" "kubeapps-operator-token" {
  metadata {
    annotations = {
      "kubernetes.io/service-account.name" = "kubeapps-operator"
    }
    name = "kubeapps-operator-token"
  }
  type  = "kubernetes.io/service-account-token"
  wait_for_service_account_token = true
}

# [Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($(kubectl get --namespace default secret kubeapps-operator-token -o jsonpath='{.data.token}')))
# minikube tunnel for fck docker
