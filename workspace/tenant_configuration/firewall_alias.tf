resource "opnsense_firewall_alias" "tenant_firewall_alias" {
  name    = replace("tbc-tenant-${var.tenant_name}", "-", "_")
  enabled = true
  type = "port"
}
