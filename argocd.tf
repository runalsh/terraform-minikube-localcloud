
resource "kubernetes_namespace" "argocd-namespace" {
  count = var.argocd ? 1 : 0  
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "6.7.18"
  namespace        = kubernetes_namespace.argocd-namespace
  count = var.argocd ? 1 : 0  
  force_update     = true
  values = [templatefile("${path.module}/values/argocdvalues.yaml", {
    host = "argocd.${var.local_domain}"
    argocdServerAdminPassword = bcrypt(var.argocd_admin_pass)
    argocdServerAdminPasswordMtime = time_static.now.rfc3339
  })]
}

resource "helm_release" "argocd_project" {
  description = "projects"
  depends_on = [
    helm_release.argocd
  ]
  name         = "projects"
  repository   = "https://argoproj.github.io/argo-helm"
  chart        = "argocd-apps"
  version      = "2.0.0"
  namespace    = kubernetes_namespace.argocd-namespace
  force_update = true
  count = var.argocd_app_of_apps ? 1 : 0 
   values = [
    yamlencode({
      projects = [
        for project in var.argocd_projects : {
          name = project
          sourceRepos = [
            "*"
          ]
          destinations = [
            {
              namespace = "*"
              server    = "*"
            }
          ]
          clusterResourceWhitelist = [
            {
              group = "*"
              kind  = "*"
            }
          ]
        }
      ]
    })
  ]
}

resource "helm_release" "application" {
  description = "Initial app of app"
  depends_on = [
    helm_release.argocd
  ]
  name         = "applications"
  repository   = "https://argoproj.github.io/argo-helm"
  chart        = "argocd-apps"
  version      = "2.0.0"
  namespace    = kubernetes_namespace.argocd-namespace
  force_update = true
  count = var.argocd_app_of_apps ? 1 : 0 
  values = [
    yamlencode({
      # field values reference -> https://github.com/argoproj/argo-helm/blob/main/charts/argocd-apps/values.yaml
      applications = [
        for key, value in var.argocd_applications : {
          name    = key
          project = value.application_project
          additionalLabels = {
            "app.kubernetes.io/managed-by" = "terraform"
          }
          source = {
            repoURL        = value.repoURL
            targetRevision = value.targetRevision
            path           = value.path
          }
          destination = {
            namespace = value.destination_namespace
            server    = "https://kubernetes.default.svc"
          }
          syncPolicy = {
            automated = {
              prune    = true
              selfHeal = true
            }
            syncOptions = [
              "CreateNamespace=true"
            ]
          }
        }
      ]
    })
  ]
}

resource "time_static" "now" {}

resource "kubectl_manifest" "argocd_dashboard" {
  yaml_body = file("${path.module}/dashboards/argocd-grafana-dashboard.yaml")
  depends_on = [
    helm_release.argocd,
    kubernetes_namespace.argocd-namespace
  ]
  count = var.argocd ? 1 : 0  
}

resource "kubectl_manifest" "argocduihttps" {
    yaml_body = file("${path.module}/manifests/argocduihttps.yaml")
    # count     = length(data.kubectl_filename_list.argocduihttps.matches)
    # yaml_body = file(element(data.kubectl_filename_list.argocduihttps.matches, count.index))
    depends_on = [
        helm_release.argocd,
        kubernetes_namespace.argocd-namespace 
    ]
    count = var.argocd ? 1 : 0 
}

# data "kubectl_filename_list" "argocduihttps" {
#     pattern = "./manifests/argocduihttps.yaml"
# }