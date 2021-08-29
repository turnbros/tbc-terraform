resource "kubernetes_secret" "rcon_password" {
  metadata {
    name      = "rcon-password"
    namespace = var.tenant_namespace
  }
  data = {
    rcon-password = random_password.rcon_password.result
  }
}