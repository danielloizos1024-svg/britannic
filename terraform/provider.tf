# provider.tf
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.6.2"
    }
    grafana = {
      source  = "grafana/grafana"
      version = "4.26.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

provider "grafana" {
  url  = "http://grafana.dlws.io:3000/"
  auth = "admin:admin" # todo create a variable
}

#--------------------------------------------------------------------------------------------
// Optional (On-premise, not supported in Grafana Cloud): Create an organization
resource "grafana_organization" "dlws_io" {
  name = "dlws_io"
}

// Create resources (optional: within the organization)
resource "grafana_folder" "infrastructure" {
  org_id = grafana_organization.dlws_io.org_id
  title  = "infrastructure"
}

resource "grafana_dashboard" "alarms" {
  org_id = grafana_organization.dlws_io.org_id
  folder = grafana_folder.infrastructure.id
  config_json = jsonencode({
    "title" : "alarms",
    "uid" : "my-dashboard-uid"
  })
}

#--------------------------------------------------------------------------------------------
resource "grafana_data_source" "prometheus" {
  type                = "prometheus"
  name                = "mimir"
  url                 = "http://172.17.0.2:9090"
  basic_auth_enabled  = true
  basic_auth_username = "admin"

  json_data_encoded = jsonencode({
    httpMethod        = "POST"
    prometheusType    = "Mimir"
    prometheusVersion = "2.4.0"
  })

  secure_json_data_encoded = jsonencode({
    basicAuthPassword = "admin"
  })
}
