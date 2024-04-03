resource "minikube_cluster" "cluster" {
  driver  = "hyperv"
#   cni     = "auto" #calico
  cluster_name      = "minikube"
  cpus              = 8
  memory            = "10000mb"
  nodes             = 1
  # kubernetes_version = "v1.29.3"
  # apiserver_ips     = ["127.0.0.1", "localhost", "192.168.50.1"]
  # subnet            = "192.168.50.0"
  # force_systemd     = true # for wsl\docker
  addons  = [
    # "dashboard",
    # "yakd", #minikube service yakd-dashboard -n yakd-dashboard
    "ingress",
    "ingress-dns",
    "default-storageclass",
    # "metrics-server",
    "storage-provisioner"   #not compatible with multi node , will use csi-driver instead -   "csi-hostpath-driver"
    ]
}

# resource "kubernetes_annotations" "csi-hostpath-annotations" {
#   api_version = "storage.k8s.io/v1"
#   kind        = "StorageClass"
#   metadata {
#     name = "csi-hostpath-sc"
#   }
#   annotations = {
#     "storageclass.kubernetes.io/is-default-class" = "true"
#   }
# }

provider "helm" {
  kubernetes {
    config_path = var.kubectl_config_path == "" ? local.kubectl_config_path : var.kubectl_config_path
    config_context = minikube_cluster.cluster.cluster_name
  }
}


resource "null_resource" "dnszone" {
  provisioner "local-exec" {
    command = "Add-DnsClientNrptRule -Namespace '.minikube.local' -NameServers $(minikube ip)"
    interpreter = ["PowerShell", "-Command"]
  }
  depends_on = [ resource.minikube_cluster.cluster ]
}

resource "null_resource" "dnszonedestroy" {
  provisioner "local-exec" {
    when       = destroy
    command = "Get-DnsClientNrptRule | Where-Object {$_.Namespace -eq '.minikube.local'} | Remove-DnsClientNrptRule -Force"
    interpreter = ["PowerShell", "-Command"]
  }
  depends_on = [ resource.minikube_cluster.cluster ]
}

# Open Powershell as Administrator and execute the following.
# Add-DnsClientNrptRule -Namespace ".minikube.local" -NameServers "$(minikube ip)"
# The following will remove any matching rules before creating a new one. This is useful for updating the minikube ip.
# Get-DnsClientNrptRule | Where-Object {$_.Namespace -eq '.minikube.local'} | Remove-DnsClientNrptRule -Force; Add-DnsClientNrptRule -Namespace ".minikube.local" -NameServers "$(minikube ip)"
# https://minikube.sigs.k8s.io/docs/handbook/addons/ingress-dns/

