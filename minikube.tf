resource "minikube_cluster" "cluster" {
  driver  = "hyperv"
#   cni     = "auto" #calico
  cluster_name      = "minikube"
  cpus              = 8
  memory            = "10000mb"
  nodes             = 1
  # apiserver_ips     = ["127.0.0.1", "localhost", "192.168.50.1"]
  # subnet            = "192.168.50.0"
  # force_systemd     = true # for wsl\docker
  addons  = [
    "dashboard",
    "ingress",
    "default-storageclass",
    # "metrics-server",
    "ingress-dns",
    "storage-provisioner"
  ]
}

# Open Powershell as Administrator and execute the following.
# Add-DnsClientNrptRule -Namespace ".test" -NameServers "$(minikube ip)"
# The following will remove any matching rules before creating a new one. This is useful for updating the minikube ip.
# Get-DnsClientNrptRule | Where-Object {$_.Namespace -eq '.test'} | Remove-DnsClientNrptRule -Force; Add-DnsClientNrptRule -Namespace ".test" -NameServers "$(minikube ip)"
# https://minikube.sigs.k8s.io/docs/handbook/addons/ingress-dns/

