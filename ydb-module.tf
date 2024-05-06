module "ydb" {
  source = "./ydb"

  count = var.ydb ? 1 : 0  
}
