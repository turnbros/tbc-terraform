#### NOTE ####
# We handle the node ports like this because we can't iterate over port_list since
# Terraform doesn't know what the length of `.port.*.node_port` is going to be

locals {
  port_list = distinct(kubernetes_service.rust_server.spec[0].port.*.node_port)
}

resource "opnsense_firewall_alias_util" "rust_server_port_alias_0" {
  name    = var.nodeport_alias_name
  address = local.port_list[0]
}

resource "opnsense_firewall_alias_util" "rust_server_port_alias_1" {
  name    = var.nodeport_alias_name
  address = local.port_list[1]
}

resource "opnsense_firewall_alias_util" "rust_server_port_alias_2" {
  name    = var.nodeport_alias_name
  address = local.port_list[2]
}

resource "opnsense_firewall_alias_util" "rust_server_port_alias_3" {
  name    = var.nodeport_alias_name
  address = local.port_list[3]
}