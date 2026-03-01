resource "docker_container" "grafana" {
  image      = docker_image.grafana.image_id
  depends_on = [docker_image.grafana]
  name       = "grafana"
  privileged = "true"
  ports {
    internal = 3000
    external = 3000
  }
}

resource "docker_container" "prometheus" {
  image      = docker_image.prometheus.image_id
  depends_on = [docker_image.prometheus]
  name       = "prometheus"
  privileged = "true"
  ports {
    internal = 9090
    external = 9090
  }
}

