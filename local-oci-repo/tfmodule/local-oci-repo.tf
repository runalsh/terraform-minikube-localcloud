# locals {
#   hosts = {
#     "100" : { name : "remote-host1", ip_address : "192.168.111.100", port: "81" }
#     "101" : { name : "remote-host2", ip_address : "192.168.111.101", port: "82"}
#   }
# }
# resource "docker_container" "nginx" {
#   for_each = local.hosts
#   name = "nginx-${each.value.name}"
#   image = "nginx:alpine"
#   hostname = "${each.value.name}-${each.key}"
#   ports {
#     internal = "${each.value.port}"
#     external = "${each.value.port}"
#     ip       = "0.0.0.0"
#   }
# }


# variable "volume" {
#   type = set(string)
#   default = ["core_data", "jobservice_data", "postgresql_data", "portainer-data", "nexus-data", "artifactory"]
# }
# resource "docker_volume" "volume" {
#   for_each = var.volume
#   name = each.value
# }
resource "docker_volume" "registry_harbor_data" { 
  name = "registry_harbor_data"
}
resource "docker_volume" "registry2_data" { 
  name = "registry2_data"
}
resource "docker_volume" "chartmuseum_data" { 
  name = "chartmuseum_data"
}
# resource "docker_volume" "core_data" {  name = "core_data"}
# resource "docker_volume" "jobservice_data" {  name = "jobservice_data"}
# resource "docker_volume" "postgresql_data" {  name = "postgresql_data"}
# resource "docker_volume" "portainer-data" {  name = "portainer-data"}
# resource "docker_volume" "nexus-data" {  name = "nexus-data"}
# resource "docker_volume" "artifactory" {  name = "artifactory"}

resource "docker_network" "local-oci-repo" { 
  name = "local-oci-repo"
}

resource "docker_container" "registry-harbor" {
  name = "registry-harbor"
  image = "bitnami/harbor-registry:2.10.2"
  env = ["REGISTRY_HTTP_SECRET=fzAYNq8hNEgTxcS"]
  ports {
    internal = "5000"
    external = "5001"
    ip       = "0.0.0.0"
  }
  volumes {
    host_path      = abspath("${path.root}/local-oci-repo/harbor/registry/")
    container_path = "/etc/registry/"
    # read_only = true
  }
  mounts {
    type = "volume"
    target = "/storage"
    source = docker_volume.registry_harbor_data.name
  }
  networks_advanced {
    name         = docker_network.local-oci-repo.name
  }
  lifecycle {
    ignore_changes = [image]
  }
}

resource "docker_container" "chartmuseum" {
  name = "chartmuseum"
  image = "ghcr.io/helm/chartmuseum:v0.16.1"
  env = ["DEBUG=1", "STORAGE=local", "STORAGE_LOCAL_ROOTDIR=/charts"]
  ports {
    internal = "8080"
    external = "5003"
    ip       = "0.0.0.0"
  }
  # volumes {
  #   host_path      = abspath("${path.root}/../local/local-chartmuseum-data/")
  #   container_path = "/charts"
  # }
  mounts {
    type = "volume"
    target = "/charts"
    source = docker_volume.chartmuseum_data.name
  }
  networks_advanced {
    name         = docker_network.local-oci-repo.name
  }
  lifecycle {
    ignore_changes = [image]
  }
}

resource "docker_container" "chartmuseum-ui" {
  name = "chartmuseum-ui"
  image = "lowid/chartmuseum-ui"
  env = ["CHART_MUSEUM_URL=http://chartmuseum:8080"]
  ports {
    internal = "8080"
    external = "5004"
    ip       = "0.0.0.0"
  }
  networks_advanced {
    name         = docker_network.local-oci-repo.name
  }
  lifecycle {
    ignore_changes = [image]
  }
}

resource "docker_container" "registry2" {
  name = "registry2"
  image = "registry:2"
  env = ["REGISTRY_STORAGE_DELETE_ENABLED=true"]
  ports {
    internal = "5000"
    external = "5002"
    ip       = "0.0.0.0"
  }
  volumes {
    host_path      = abspath("${path.root}/local-oci-repo/registry2.yml") #abspath("${path.root}/vault-tls/output")
    container_path = "/etc/docker/registry/config.yml"
    read_only = true
  }
  mounts {
    type = "volume"
    target = "/etc/docker/registry/access"
    source = docker_volume.registry2_data.name
  }
  mounts {
    type = "volume"
    target = "/var/lib/registry"
    source = docker_volume.registry2_data.name
  }
  mounts {
    type = "volume"
    target = "/certs"
    source = docker_volume.registry2_data.name
  }
  networks_advanced {
    name = docker_network.local-oci-repo.name
  }
  lifecycle {
    ignore_changes = [image]
  }
}

resource "docker_container" "registry-ui" {
  name = "registry-ui"
  image = "joxit/docker-registry-ui:main"
  env = ["SINGLE_REGISTRY=false", "REGISTRY_TITLE=Docker Registry UI", "SINGLE_REGISTRY=false", "REGISTRY_TITLE=Docker Registry UI", "DELETE_IMAGES=true", "SHOW_CONTENT_DIGEST=true", "NGINX_PROXY_PASS_URL=http://localhost:5001","DEFAULT_REGISTRIES=http://localhost:5001,http://localhost:5002", "SHOW_CATALOG_NB_TAGS=true", "CATALOG_MIN_BRANCHES=1","CATALOG_MAX_BRANCHES=1", "TAGLIST_PAGE_SIZE=100", "REGISTRY_SECURED=false", "CATALOG_ELEMENTS_LIMIT=1000", "REGISTRY_ALLOW_DELETE=true"]
  ports {
    internal = "80"
    external = "80"
    ip       = "0.0.0.0"
  }
  networks_advanced {
    name         = docker_network.local-oci-repo.name
  }
  lifecycle {
    ignore_changes = [image]
  }
}


# resource "docker_container" "local-oci-repo" {
#   count = var.local-oci-repo ? 1 : 0

#   name  = "nginx"
#   image = "nginx:alpine"

#   # env = [
#   #   "VAULT_ADDR=https://0.0.0.0:8200",
#   #   "VAULT_RAFT_NODE_ID=${each.key}",
#   # ]

#   # capabilities {
#   #   add = [
#   #     "IPC_LOCK",
#   #   ]
#   # }

#   ports {
#     internal = 80
#     external = 80
#     ip       = "0.0.0.0"
#   }

#   # volumes {
#   #   host_path      = abspath(local_file.vault.filename)
#   #   container_path = "/vault/config/vault.hcl"
#   #   read_only      = true
#   # }
  # volumes {
  #   container_path = "/home/coder/"
  #   volume_name    = docker_volume.home_volume.name
  #   read_only      = false
  # }
  # volumes {
  #   container_path = "/var/run/docker.sock"
  #   host_path = "/var/run/docker.sock"
  # }
#   # volumes {
#   #   host_path      = abspath("${path.root}/vault-tls/output")
#   #   container_path = "/opt/tls/"
#   #   read_only      = true
#   # }
    #   mounts {
    # type = "volume"
    # target = "/var/lib/mysql"
    # source = "db_data"
    # }
#   # command = ["server"]

#   # # allow vault access localhost
#   # host {
#   #   host = "host.docker.internal"
#   #   ip   = "host-gateway"
#   # }

#   # networks_advanced {
#   #   name         = docker_network.vault.name
#   #   ipv4_address = each.value.ip
#   # }

#   # lifecycle {
#   #   ignore_changes = all
#   # }
# }

# resource "docker_volume" "db_data" {
#   name = "db_data"
# }

# resource "docker_network" "local-oci-repo" {
#   name = "local-oci-repo"
# }






























