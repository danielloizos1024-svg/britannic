# images.tf

resource "docker_image" "grafana" {
  name = "grafana/grafana"
}

resource "docker_image" "prometheus" {
  name = "prom/prometheus"
}

