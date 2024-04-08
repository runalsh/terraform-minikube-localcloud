
resource "docker_container" "local-oci-repo" {
  count = var.local-oci-repo ? 1 : 0

  name  = each.key
  image = "hashicorp/vault:${var.vault_version}"

  env = [
    "VAULT_ADDR=https://0.0.0.0:8200",
    "VAULT_RAFT_NODE_ID=${each.key}",
  ]

  capabilities {
    add = [
      "IPC_LOCK",
    ]
  }

  ports {
    internal = 8200
    external = each.value.port
    ip       = "0.0.0.0"
  }

  volumes {
    host_path      = abspath(local_file.vault.filename)
    container_path = "/vault/config/vault.hcl"
    read_only      = true
  }

  volumes {
    host_path      = abspath("${path.root}/vault-tls/output")
    container_path = "/opt/tls/"
    read_only      = true
  }

  command = ["server"]

  # allow vault access localhost
  host {
    host = "host.docker.internal"
    ip   = "host-gateway"
  }

  networks_advanced {
    name         = docker_network.vault.name
    ipv4_address = each.value.ip
  }

  lifecycle {
    ignore_changes = all
  }
}