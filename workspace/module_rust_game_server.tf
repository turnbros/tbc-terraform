module "rust_game_server" {
  source   = "./modules/rust_game_server"
  for_each = { for instance in local.rust_game_server_params : instance["name"] => instance }

  tenant_name      = var.tenant_name
  tenant_namespace = module.tenant_configuration.namespace_name
  nodeport_alias_name = var.nodeport_alias_name

  rust_server_port = 28015
  rust_rcon_port   = 28016
  rust_app_port    = 28082

  rust_branch                   = contains(keys(each.value["parameters"]), "rust_branch") ? each.value["parameters"]["rust_branch"] : null
  rust_rcon_web                 = contains(keys(each.value["parameters"]), "rust_rcon_web") ? each.value["parameters"]["rust_rcon_web"] : null
  rust_server_banner_url        = contains(keys(each.value["parameters"]), "rust_server_banner_url") ? each.value["parameters"]["rust_server_banner_url"] : null
  rust_server_description       = contains(keys(each.value["parameters"]), "rust_server_description") ? each.value["parameters"]["rust_server_description"] : null
  rust_server_identity          = contains(keys(each.value["parameters"]), "rust_server_identity") ? each.value["parameters"]["rust_server_identity"] : null
  rust_server_maxplayers        = contains(keys(each.value["parameters"]), "rust_server_maxplayers") ? each.value["parameters"]["rust_server_maxplayers"] : null
  rust_server_name              = contains(keys(each.value["parameters"]), "rust_server_name") ? each.value["parameters"]["rust_server_name"] : null
  rust_server_save_interval     = contains(keys(each.value["parameters"]), "rust_server_save_interval") ? each.value["parameters"]["rust_server_save_interval"] : null
  rust_server_seed              = contains(keys(each.value["parameters"]), "rust_server_seed") ? each.value["parameters"]["rust_server_seed"] : null
  rust_server_startup_arguments = contains(keys(each.value["parameters"]), "rust_server_startup_arguments") ? each.value["parameters"]["rust_server_startup_arguments"] : null
  rust_server_url               = contains(keys(each.value["parameters"]), "rust_server_url") ? each.value["parameters"]["rust_server_url"] : null
  rust_server_worldsize         = contains(keys(each.value["parameters"]), "rust_server_worldsize") ? each.value["parameters"]["rust_server_worldsize"] : null
  rust_update_branch            = contains(keys(each.value["parameters"]), "rust_update_branch") ? each.value["parameters"]["rust_update_branch"] : null
  rust_update_checking          = contains(keys(each.value["parameters"]), "rust_update_checking") ? each.value["parameters"]["rust_update_checking"] : null
}