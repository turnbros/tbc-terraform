#### NOTE ####
# We handle the node ports like this because we can't iterate over port_list since
# Terraform doesn't know what the length of `.port.*.node_port` is going to be

locals {
  port_list = distinct(kubernetes_service.rust_server.spec[0].port.*.node_port)
}

resource "opnsense_firewall_alias" "tenant_firewall_alias" {
  name    = "test_alias_name" #var.nodeport_alias_name
  enabled = true
  type = "port"
  content = toset(local.port_list)
}
