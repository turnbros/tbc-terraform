output "namespace_name" {
  value = kubernetes_namespace.tenant_namespace.metadata.0.name
}