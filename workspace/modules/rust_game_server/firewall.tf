resource "opnsense_firewall_alias_util" "rust_server_port_alias" {
  count   = length(kubernetes_service.rust_server.spec[0].port)
  name    = var.nodeport_alias_name
  address = kubernetes_service.rust_server.spec[0].port[count.index].node_port
}