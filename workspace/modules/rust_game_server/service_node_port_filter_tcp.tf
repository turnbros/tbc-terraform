locals {
  tcp_ports = [
    local.server_tcp_port,
    local.rcon_port,
    local.rcon_app_port,
    local.app_port
  ]
}
resource "kubernetes_manifest" "nodeport_filter_tcp" {
  depends_on = [kubernetes_manifest.rust_server_nodeport_reservation]
  count = length(local.tcp_ports)
  manifest = {
    apiVersion = "opnsense.turnbros.app/v1alpha1"
    kind       = "FirewallFilter"
    metadata = {
      "name"      = "${local.server_name}-filter-tcp-${local.tcp_ports[count.index]}"
      "namespace" = var.tenant_namespace
    }
    spec = {
      api_secret_name      = var.cluster_firewall_api_secret_name
      api_secret_namespace = var.cluster_firewall_api_secret_namespace
      action               = "pass"
      direction            = "in"
      interface            = ["wan"]
      protocol         = "TCP"
      source_net       = "any"
      source_port      = 0
      destination_net  = var.cluster_firewall_alias
      destination_port = local.tcp_ports[count.index]
      description      = "Permit internet ingress for ${local.server_name} on TCP port ${local.tcp_ports[count.index]}"
      enabled          = true
      state            = "present"
    }
  }
}