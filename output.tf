# resource "terraform_data" "shownodeportforargocd" {
#   provisioner "local-exec" {
#     command =  "kubectl get svc argocd-server -n argocd -o=jsonpath='{.spec.ports[?(@.name=='http')].nodePort}'"
#   }
# }

# output "shownodeportforargocd" {
#   value = terraform_data.shownodeportforargocd.output
#   description = "argocd nodeport"
# }

