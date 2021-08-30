resource "kubernetes_secret" "rcon_password" {
  metadata {
    name      = local.server_name
    namespace = var.tenant_namespace
  }
  data = {
    rcon-password = random_password.rcon_password.result
  }
}