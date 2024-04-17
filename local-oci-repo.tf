module "local-oci-repo" {
  source = "./local-oci-repo/tfmodule"

  count = var.local-oci-repo ? 1 : 0  
}
