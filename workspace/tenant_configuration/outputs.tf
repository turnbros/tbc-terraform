output "namespace_name" {
  value = kubernetes_namespace.tenant_namespace.metadata.0.name
}
output "tenant_firewall_alias_id" {
  value = opnsense_firewall_alias.tenant_firewall_alias.id
}