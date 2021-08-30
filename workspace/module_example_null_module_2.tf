module "example_null_module_2" {
  source   = "./modules/example_null_module_2"
  for_each = { for instance in local.example_null_module_2_params : instance["name"] => instance }
  value_a  = each.value["parameters"]["value_a"]
  value_b  = each.value["parameters"]["value_b"]
  value_c  = each.value["parameters"]["value_c"]
}