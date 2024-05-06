# resource "docker_volume" "portainer_data" { 
#   name = "portainer_data"
# }

# docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /local/local-portainer-data/:/data portainer/portainer-ce:latest
# docker run -d   -p 100.85.46.1:9001:9001   --name portainer_agent   --restart=always   -v /var/run/docker.sock:/var/run/docker.sock   -v /var/lib/docker/volumes:/var/lib/docker/volumes   portainer/agent:alpine-sts
# docker run -d   -p 100.103.220.135:9001:9001   --name portainer_agent   --restart=always   -v /var/run/docker.sock:/var/run/docker.sock   -v /var/lib/docker/volumes:/var/lib/docker/volumes   portainer/agent:alpine-sts


resource "docker_container" "portainer" {
  count = var.local-portainer ? 1 : 0
  name = "portainer"
  image = "portainer/portainer-ce:alpine" # portainer-ce:alpine-sts doesnt have live parallel connections and using old (2023) portainer:latest image v2.16.2
  env = [ "TZ=Europe/Moscow" ]
  ports {
    internal = "9443" #https gui
    external = "9443"
    ip       = "0.0.0.0"
  }
  ports {
    internal = "8000"
    external = "8000"
    ip       = "0.0.0.0"
  }
  ports {
    internal = "9000"  #http gui
    external = "9000"
    ip       = "0.0.0.0"
  }
  volumes {
    host_path      = abspath("${path.root}/local/local-portainer-data/")  #admin:admin
    container_path = "/data"
    # read_only = true
  }
#   mounts {
#     type = "volume"
#     target = "/data"
#     source = docker_volume.portainer_data.name
#   }
  lifecycle {
    ignore_changes = [image]
  }
}