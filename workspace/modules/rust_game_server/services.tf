resource "kubernetes_service" "rust_server" {
  metadata {
    name      = local.server_name
    namespace = var.tenant_namespace
    labels = merge({
      "app.kubernetes.io/name" : local.server_name,
      "cloud.turnbros.app/tenant" : var.tenant_name
      "opnsense.turnbros.app/api-secret" : var.cluster_firewall_api_secret_name,
      "opnsense.turnbros.app/api-secret-namespace" : var.cluster_firewall_api_secret_namespace,
      "opnsense.turnbros.app/filter-expose" : true,
      "opnsense.turnbros.app/filter-enabled" : true,
      "opnsense.turnbros.app/filter-destination-net" : var.cluster_firewall_alias,
      "opnsense.turnbros.app/filter-interface" : var.cluster_firewall_external_interface
    }, local.labels)
  }
  spec {
    type = "NodePort"
    selector = {
      "app.kubernetes.io/name" = local.server_name,
      "cloud.turnbros.app/tenant" : var.tenant_name
    }
    port {
      name        = "server-tcp"
      protocol    = "TCP"
      port        = var.rust_server_port
      target_port = var.rust_server_port
    }
    port {
      name        = "server-udp"
      protocol    = "UDP"
      port        = var.rust_server_port
      target_port = var.rust_server_port
    }
    port {
      name        = "rcon"
      protocol    = "TCP"
      port        = var.rust_rcon_port
      target_port = var.rust_rcon_port
    }
    # TODO: This should be a TLS terminated ingress route
    port {
      name        = "rcon-app"
      protocol    = "TCP"
      port        = 8080
      target_port = 8080
    }
    port {
      name        = "app"
      protocol    = "TCP"
      port        = var.rust_app_port
      target_port = var.rust_app_port
    }
  }
}