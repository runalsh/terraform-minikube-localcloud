resource "minikube_cluster" "cluster" {
  driver  = "hyperv"
#   cni     = "auto"
  cluster_name = var.clustername
  cpus         = 8
  memory       = "4000mb"
  nodes        = 1
  addons  = [
    "dashboard",
    "ingress",
    "default-storageclass",
    "storage-provisioner"
  ]
}


