module "minikube" {
  source = "./minikube"
  
  count = var.minikube ? 1 : 0

  nodes   = var.minikube_param.nodes
  kubernetes_version = var.minikube_param.kubernetes_version
  name = var.minikube_param.cluster_name
  memory = var.minikube_param.memory
  cpu = var.minikube_param.cpu
  driver = var.minikube_param.driver
}
