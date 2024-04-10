# Selfhosted cloud for local development ( on Windows )
## terraform - minikube - hyper-v
Ready:
  -  argocd,
  -  grafana prometheus loki promtail,
  -  harbor,
  -  nexus,
  -  portainer,
  -  gitlab,
  -  gitlab runner,
  -  localstack (aws emulator),
  -  cert-manager,
  -  argocd rollout + image updater,
  -  minio,
  -  cloudnative-pg + init db,
  -  github runner controller,
  -  vault,
  -  vault + consul secret managment for simple internal apps with example,
  -  csi secret storage + vault,
  -  vault local instance (non k8s) used by terrafom provider,
  -  vault local on docker with haproxy as load balancer (module),
  -  local OCI registry (registry, harbor, nexus, artifactory),
  -  minikube as module

Plans: 
  - https://github.com/vmware-tanzu/kubeapps 
  -  integrate gitlab/github action with minio (as s3 cache) and harbor\nexus,
  -  jaeger,
  -  openfaas (very very interesting),
  -  trivy (aqua?),
  -  crossplane (for fun, idn working it with minikube or not)


