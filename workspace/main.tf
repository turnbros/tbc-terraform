module "tenant_configuration" {
  source              = "./tenant_configuration"
  tenant_name         = var.tenant_name
  nodeport_alias_uuid = var.nodeport_alias_uuid
}



