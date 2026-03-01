resource "docker_network" "private_network" {
  name       = "monitoring"
  attachable = "true"
}

