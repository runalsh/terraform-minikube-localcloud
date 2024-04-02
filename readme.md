## Selfhosted local cloud ( on Windows :D ) - minikube via hyper-v with terraform
Ready:
argocd,
grafana prometheus loki promtail,
harbor,
nexus,
portainer,
gitlab,
gitlab runner,
localstack (aws emulator),
cert-manager,
argocd rollout + image updater,
minio,
cloudnative-pg + init db

Plans: 
integrate gitlab with minio (as s3 cache) and harbor\nexus,
github runner,
vault,
jaeger,
openfaas (very very interesting),
trivy (aqua?),
crossplane (for fun, idn working it with minikube or not)

Big plan: 
made all as tf modules or as argocd charts
