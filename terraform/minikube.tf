resource "minikube_cluster" "cluster" {
  driver  = "docker"
#   cni     = "auto"
  cluster_name = var.clustername
  cpus         = 2
  memory       = "2000mb"
  nodes        = 2
  addons  = [
    "dashboard",
    # "ingress",
    "default-storageclass",
    "storage-provisioner"
  ]
}


