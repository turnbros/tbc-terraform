module "example_null_module_1" {
  source   = "./modules/example_null_module_1"
  for_each = local.tenant_modules["example_null_module_1"]
  value_1  = each.value["parameters"]["value_1"]
  value_2  = each.value["parameters"]["value_2"]
  value_3  = each.value["parameters"]["value_3"]
}
module "example_null_module_2" {
  source   = "./modules/example_null_module_2"
  for_each = local.tenant_modules["example_null_module_2"]
  value_a  = each.value["parameters"]["value_a"]
  value_b  = each.value["parameters"]["value_b"]
  value_c  = each.value["parameters"]["value_c"]
}
module "example_null_module_3" {
  source    = "./modules/example_null_module_3"
  for_each  = local.tenant_modules["example_null_module_3"]
  value_foo = each.value["parameters"]["value_foo"]
  value_bar = each.value["parameters"]["value_bar"]
  value_baz = each.value["parameters"]["value_baz"]
}