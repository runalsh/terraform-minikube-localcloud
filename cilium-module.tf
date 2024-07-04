module "cilium" {
  source = "./cilium"

  kind_local_domain=var.kind_local_domain

  count = var.cilium ? 1 : 0
}