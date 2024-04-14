

module "kubeapps" {
  source = "./kubeapps"
  
  count = var.kubeapps ? 1 : 0

  local_domain = var.local_domain
}
