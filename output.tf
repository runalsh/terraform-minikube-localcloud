# resource "terraform_data" "shownodeportforargocd" {
#   provisioner "local-exec" {
#     command =  "kubectl get svc argocd-server -n argocd -o=jsonpath='{.spec.ports[?(@.name=='http')].nodePort}'"
#   }
# }

# output "shownodeportforargocd" {
#   value = terraform_data.shownodeportforargocd.output
#   description = "argocd nodeport"
# }

# resource "terraform_data" "Get-DnsClientNrptRule" {
#   provisioner "local-exec" {
#     command =  "DnsClientNrptRule -Namespace \".minikube.local\""
#     interpreter = ["PowerShell", "-Command"]
#   }
#   depends_on = [ resource.minikube_cluster.cluster ]
# }

# output "Get-DnsClientNrptRule" {
#   value = terraform_data.Get-DnsClientNrptRule.output
#   description = "dns rule"
# }