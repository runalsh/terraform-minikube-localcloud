resource "kubernetes_namespace" "github-runner-controller" {
 count = var.github-runner-controller ? 1 : 0
 metadata {
   name = "github-runner-controller"
 }
}

resource "helm_release" "github-runner-controller" {
 name             = "actions-runner-controller"
 repository       = "https://actions-runner-controller.github.io/actions-runner-controller"
 chart            = "actions-runner-controller"
 version          = "v0.23.7"
 namespace        = "github-runner-controller"
 count = var.github-runner-controller ? 1 : 0
 values = [templatefile("${path.module}/values/github-runner-controller.yaml", {
    githubkey = "${data.local_sensitive_file.githubkey.content}"
  })]
 depends_on = [ kubernetes_namespace.github-runner-controller ]
}

resource "kubectl_manifest" "github-runner-controller" {
    yaml_body = file("${path.module}/manifests/github-runner-controller.yaml")
    depends_on = [ kubernetes_namespace.github-runner-controller ]
    count = var.github-runner-controller ? 1 : 0
}

data "local_sensitive_file" "githubkey" {
  filename = "${path.module}/local/githubkey.json"
}


