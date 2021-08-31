#### NOTE ####
# We handle the node ports like this because we can't iterate over port_list since
# Terraform doesn't know what the length of `.port.*.node_port` is going to be


resource "random_id" "firewall_alias_id" {
  byte_length = 4
}


locals {
  port_list = distinct(kubernetes_service.rust_server.spec[0].port.*.node_port)
}

resource "opnsense_firewall_alias" "tenant_firewall_alias" {
  parent = [var.tenant_firewall_alias_id]
  name    = "tbc_${random_id.firewall_alias_id.id}"
  enabled = true
  type = "port"
  description = "${var.tenant_name}"
  content = toset(local.port_list)
}
