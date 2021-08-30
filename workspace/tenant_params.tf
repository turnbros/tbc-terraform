data "http" "tenant_resources" {
  url = "${var.tbc_api_endpoint}/tenants/${var.tenant_name}/workspace/variables"
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  tenant_params = jsondecode(data.http.tenant_resources.body)

  example_null_module_1_params = try(length(local.tenant_params["example_null_module_1"]) > 0 ? local.tenant_params["example_null_module_1"] : tolist(false), [])
  example_null_module_2_params = try(length(local.tenant_params["example_null_module_2"]) > 0 ? local.tenant_params["example_null_module_2"] : tolist(false), [])
  example_null_module_3_params = try(length(local.tenant_params["example_null_module_3"]) > 0 ? local.tenant_params["example_null_module_3"] : tolist(false), [])
  minecraft_game_server_params = try(length(local.tenant_params["minecraft_game_server"]) > 0 ? local.tenant_params["minecraft_game_server"] : tolist(false), [])
  rust_game_server_params      = try(length(local.tenant_params["rust_game_server"]) > 0 ? local.tenant_params["rust_game_server"] : tolist(false), [])
}