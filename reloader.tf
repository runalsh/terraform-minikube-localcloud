resource "helm_release" "reloader" {
  name       = "reloader"
  repository = "https://stakater.github.io/stakater-charts"
  chart      = "reloader"
  version    = "v1.0.89"

  count = var.reloader ? 1 : 0
#   values = [file("${path.module}/values/reloader.yaml")]
}  