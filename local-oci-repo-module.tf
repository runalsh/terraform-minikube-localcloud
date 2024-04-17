module "local-oci-repo" {
  source = "./local-oci-repo/tfmodule"

  count = var.local-oci-repo ? 1 : 0 
  
  registry2 = var.local-oci-repoparam.registry2
  harbour = var.local-oci-repoparam.harbour
  chartmuseum = var.local-oci-repoparam.chartmuseum
  chartmuseum-ui = var.local-oci-repoparam.chartmuseum-ui
  registry-ui = var.local-oci-repoparam.registry-ui

}
