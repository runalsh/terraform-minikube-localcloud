resource "kubernetes_namespace" "localstack-namespace" {
  count = var.localstack ? 1 : 0
  metadata {
    name = "localstack"
  }
}

resource "kubectl_manifest" "localstack-cert" {
  yaml_body = templatefile("${path.module}/values/localstack-cert.yaml", {
    domain-name = var.local_domain
    namespace   = "localstack"
  })
  depends_on = [ kubernetes_namespace.localstack-namespace ]
  count = var.localstack ? 1 : 0
}

resource "helm_release" "localstack" {
  name          = "localstack"
  repository    = "https://localstack.github.io/helm-charts"
  chart         = "localstack"
  version       = "0.6.10"
  namespace     = "localstack"

  count = var.localstack ? 1 : 0
  wait          = true
  wait_for_jobs = true
  values = [
    templatefile("${path.module}/values/localstack-values.yaml", {
      domain-name = var.local_domain
      namespace   = "localstack"
      debug       = false
    })
  ]
  depends_on = [ kubernetes_namespace.localstack-namespace, resource.kubectl_manifest.localstack-cert ]
}