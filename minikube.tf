resource "minikube_cluster" "cluster" {
  driver  = "hyperv"
#   cni     = "auto" #calico
  cluster_name      = var.clustername
  cpus              = 8
  memory            = "10000mb"
  delete_on_failure = true
  nodes             = 1
  # apiserver_ips     = ["127.0.0.1", "localhost", "192.168.50.1"]
  # subnet            = "192.168.50.0"
  # force_systemd     = true # for wsl\docker
  addons  = [
    "dashboard",
    "ingress",
    "default-storageclass",
    # "metrics-server",
    # "ingress-dns",
    "storage-provisioner"
  ]
}


