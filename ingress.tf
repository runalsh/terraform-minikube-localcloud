# resource "kubectl_manifest" "argocduihttps" {
#     yaml_body = <<YAML
# apiVersion: networking.k8s.io/v1
# kind: Ingress
# metadata:
#   name: argocd-server-https
#   namespace: argocd
#   annotations:
#     nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
#     nginx.ingress.kubernetes.io/ssl-passthrough: "true"
# spec:
#   ingressClassName: nginx
#   rules:
#   - host: argocd.io
#     http:
#       paths:
#         - pathType: Prefix
#           path: /
#           backend:
#             service: 
#               name: argocd-server
#               port: 
#                 name: https

# YAML
# }

# resource "kubectl_manifest" "argocduihttp" {
#     yaml_body = <<YAML
# apiVersion: networking.k8s.io/v1
# kind: Ingress
# metadata:
#   name: argocd-server-http
#   namespace: argocd
#   annotations:
#     # kubernetes.io/ingress.class: nginx
# spec:
#   ingressClassName: nginx
#   rules:
#   - host: argocd.io
#     http:
#       paths:
#         - pathType: Prefix
#           path: /
#           backend:
#             service: 
#               name: argocd-server
#               port: 
#                 name: http

# YAML
# }

# resource "kubernetes_manifest" "argocduihttps" {

#   manifest = <<EOT
# apiVersion: networking.k8s.io/v1
# kind: Ingress
# metadata:
#   name: argocd-server-https
#   namespace: argocd
#   annotations:
#     nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
#     nginx.ingress.kubernetes.io/ssl-passthrough: "true"
# spec:
#   ingressClassName: nginx
#   rules:
#   - host: argocd.io
#     http:
#       paths:
#         - pathType: Prefix
#           path: /
#           backend:
#             service: 
#               name: argocd-server
#               port: 
#                 name: https
# EOT
# }

