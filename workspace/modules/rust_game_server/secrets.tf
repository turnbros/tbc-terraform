resource "kubernetes_secret" "rcon_password" {
  metadata {
    name      = "rcon-password"
    namespace = var.tenant_namespace
  }
  data = {
    rcon_password = random_password.rcon_password.result
  }
}