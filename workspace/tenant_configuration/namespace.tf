resource "kubernetes_namespace" "tenant_namespace" {
  metadata {
    name = "tbc-tenant-${var.tenant_name}"
    labels = {
      "app.kubernetes.io/name" : "tbc-tenant-${var.tenant_name}",
      "cloud.turnbros.app/tenant" : var.tenant_name
    }
  }
}