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
        "app.kubernetes.io/name" : local.server_name,
        "cloud.turnbros.app/tenant" : var.tenant_name
      },
      annotations = {
        foo : "bar"
      },
      selector = {
        "app.kubernetes.io/name" : local.server_name,
        "cloud.turnbros.app/tenant" : var.tenant_name
      },
      ports = [
        { name = "server", protocols = ["tcp", "udp"] },
        { name = "rcon", protocols = ["tcp"] },
        { name = "rcon-app", protocols = ["tcp"] },
        { name = "app", protocols = ["tcp"] }
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
    name      = local.server_name
    namespace = var.tenant_namespace
  }
}

locals {
  server_tcp_port = [for port in data.kubernetes_service.rust_server_nodeport_service.spec.0.port : port["node_port"] if port["name"] == "server-tcp"][0]
  server_udp_port = [for port in data.kubernetes_service.rust_server_nodeport_service.spec.0.port : port["node_port"] if port["name"] == "server-udp"][0]
  rcon_port       = [for port in data.kubernetes_service.rust_server_nodeport_service.spec.0.port : port["node_port"] if port["name"] == "rcon-tcp"][0]
  rcon_app_port   = [for port in data.kubernetes_service.rust_server_nodeport_service.spec.0.port : port["node_port"] if port["name"] == "rcon-app-tcp"][0]
  app_port        = [for port in data.kubernetes_service.rust_server_nodeport_service.spec.0.port : port["node_port"] if port["name"] == "app-tcp"][0]
}