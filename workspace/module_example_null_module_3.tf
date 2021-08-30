module "example_null_module_3" {
  source    = "./modules/example_null_module_3"
  for_each  = { for instance in local.example_null_module_3_params : instance["name"] => instance }
  value_foo = each.value["parameters"]["value_foo"]
  value_bar = each.value["parameters"]["value_bar"]
  value_baz = each.value["parameters"]["value_baz"]
}