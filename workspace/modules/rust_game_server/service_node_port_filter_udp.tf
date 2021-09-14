resource "kubernetes_manifest" "nodeport_filter_udp" {
  depends_on = [kubernetes_manifest.rust_server_nodeport_reservation]
  manifest = {
    apiVersion = "opnsense.turnbros.app/v1alpha1"
    kind       = "FirewallFilter"
    metadata = {
      "name"      = "${local.server_name}-filter-udp-${local.server_udp_port}"
      "namespace" = var.tenant_namespace
    }
    spec = {
      api_secret_name      = var.cluster_firewall_api_secret_name
      api_secret_namespace = var.cluster_firewall_api_secret_namespace
      action               = "pass"
      direction            = "in"
      interface = ["wan"]
      protocol         = "UDP"
      source_net       = "any"
      source_port      = 0
      destination_net  = var.cluster_firewall_alias
      destination_port = local.server_udp_port
      description      = "Permit internet ingress for ${local.server_name} on UDP port ${local.server_udp_port}"
      enabled          = true
      state            = "present"
    }
  }
}