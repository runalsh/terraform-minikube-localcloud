module "kind" {
  source = "./kind"

  name = var.kind_cluster_name
  kind_local_domain = var.kind_local_domain

  count = var.kind ? 1 : 0  
}  