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
cloudnative-pg + init db,
github runner,
vault,
vault + consul secret managment for internal apps

Plans: 
add tf module for vault to managment secrets outside cluster on deploy,
integrate gitlab with minio (as s3 cache) and harbor\nexus,
jaeger,
openfaas (very very interesting),
trivy (aqua?),
crossplane (for fun, idn working it with minikube or not)


