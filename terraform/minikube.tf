resource "minikube_cluster" "cluster" {
  vm      = true
  driver  = "docker"
  cni     = "bridge"
  addons  = [
    "dashboard",
    "default-storageclass",
    "storage-provisioner"
  ]
}

