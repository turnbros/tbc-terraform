data "http" "tenant_resources" {
  url = "${var.tbc_api_endpoint}/tenant/${var.tenant_name}/workspace/variables"
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  tenant_params = jsondecode(data.http.tenant_resources.body)
  tenant_modules = {
    example_null_module_1 = contains(keys(local.tenant_params), "example_null_module_1") ? local.tenant_params["example_null_module_1"] : {}
    example_null_module_2 = contains(keys(local.tenant_params), "example_null_module_2") ? local.tenant_params["example_null_module_2"] : {}
    example_null_module_3 = contains(keys(local.tenant_params), "example_null_module_3") ? local.tenant_params["example_null_module_3"] : {}
    minecraft_game_server = contains(keys(local.tenant_params), "minecraft_game_server") ? local.tenant_params["minecraft_game_server"] : {}
    rust_game_server = contains(keys(local.tenant_params), "rust_game_server") ? local.tenant_params["rust_game_server"] : {}
  }
}