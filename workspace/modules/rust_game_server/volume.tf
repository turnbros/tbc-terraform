resource "kubernetes_persistent_volume_claim" "rust_volume" {
  metadata {
    name      = local.server_name
    namespace = var.tenant_namespace
    labels = merge({
      "app.kubernetes.io/name" : local.server_name,
      "cloud.turnbros.app/tenant" : var.tenant_name
    }, local.labels)
  }
  spec {
    # TODO: This needs to be variable
    storage_class_name = "kube-rook"
    access_modes       = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "7Gi"
      }
    }
  }
}