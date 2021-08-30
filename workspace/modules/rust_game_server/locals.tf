resource "random_pet" "instance_name" {}
resource "random_password" "rcon_password" {
  length = 10
}
resource "random_integer" "rust_server_seed" {
  min = 10000
  max = 99999
}
locals {
  image             = "ghcr.io/turnbros/rust-server/rust_server:latest"
  image_pull_policy = "IfNotPresent"

  server_name = local.instance_id

  cpu_request    = "2000m"
  memory_request = "4096Mi"
  cpu_limit      = "2000m"
  memory_limit   = "6144Mi"

  rust_start_mode           = 1
  rust_oxide_enabled        = 1
  rust_oxide_update_on_boot = 1

  instance_id      = random_pet.instance_name.id
  rust_server_seed = var.rust_server_seed == null ? random_integer.rust_server_seed.result : var.rust_server_seed
  labels = {
    "app.kubernetes.io/instance" = local.instance_id
  }
}