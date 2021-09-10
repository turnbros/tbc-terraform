resource "kubernetes_manifest" "rust_server_nodeport_reservation" {
  manifest = {
    apiVersion = "networking.turnbros.app/v1alpha1"
    kind       = "NodePortPassthrough"
    metadata = {
      "name"      = local.server_name
      "namespace" = var.tenant_namespace
    }
    spec = {
      labels = {
        "app.kubernetes.io/name"                       = local.server_name,
        "cloud.turnbros.app/tenant"                    = var.tenant_name
        "opnsense.turnbros.app/api-secret"             = var.cluster_firewall_api_secret_name,
        "opnsense.turnbros.app/api-secret-namespace"   = var.cluster_firewall_api_secret_namespace,
        "opnsense.turnbros.app/filter-expose"          = true,
        "opnsense.turnbros.app/filter-enabled"         = true,
        "opnsense.turnbros.app/filter-destination-net" = var.cluster_firewall_alias,
        "opnsense.turnbros.app/filter-interface"       = var.cluster_firewall_external_interface
      },
      selector = {
        "app.kubernetes.io/name"    = local.server_name,
        "cloud.turnbros.app/tenant" = var.tenant_name
      }
      ports = [
        { name = "server", protocols = ["TCP", "UDP"] },
        { name = "rcon", protocols = ["TCP"] },
        { name = "rcon-app", protocols = ["TCP"] },
        { name = "app", protocols = ["TCP"] }
      ]
    }
  }
  wait_for = {
    fields = {
      "status.conditions[0].reason" = "Successful"
    }
  }
}

data "kubernetes_service" "rust_server_nodeport_service" {
  metadata {
    name = kubernetes_manifest.rust_server_nodeport_reservation.manifest.metadata.name
  }
}

locals {
  server_tcp_port = [for port in data.kubernetes_service.rust_server_nodeport_service.spec.0.port : port if port["name"] == "server-tcp"]
  server_udp_port = [for port in data.kubernetes_service.rust_server_nodeport_service.spec.0.port : port if port["name"] == "server-udp"]
  rcon_port       = [for port in data.kubernetes_service.rust_server_nodeport_service.spec.0.port : port if port["name"] == "rcon-tcp"]
  rcon_app_port   = [for port in data.kubernetes_service.rust_server_nodeport_service.spec.0.port : port if port["name"] == "rcon-app-tcp"]
  app_port        = [for port in data.kubernetes_service.rust_server_nodeport_service.spec.0.port : port if port["name"] == "app-tcp"]
}