# self-hosted cloud for local development ( windows )
## iac terraform - minikube - vm hyper-v
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
  -  local OCI registry as terraform and compose (registry, harbor, portainer, nexus, artifactory),
  -  minikube as module,
  -  local-portainer for manage vps docker instances and few local,
  -  kubeapps as module

Plans: 
  -  integrate gitlab/github action with minio (as s3 cache) and harbor\nexus,
  -  jaeger,
  -  openfaas (very very interesting),
  -  trivy (aqua?),
  -  crossplane (for fun, idn working it with minikube or not)


