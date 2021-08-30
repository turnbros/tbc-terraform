module "example_null_module_1" {
  source   = "./modules/example_null_module_1"
  for_each = { for instance in local.example_null_module_1_params : instance["name"] => instance }
  value_1  = each.value["parameters"]["value_1"]
  value_2  = each.value["parameters"]["value_2"]
  value_3  = each.value["parameters"]["value_3"]
}