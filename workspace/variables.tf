variable "kube_host" {}
variable "kube_cluster_ca_cert" {}
variable "kube_client_key" {}
variable "kube_client_cert" {}

variable "tbc_api_endpoint" {
  type        = string
  description = "The API endpoint for TBC"
  default     = "http://192.168.1.206:8444"
}
variable "tenant_name" {
  type        = string
  description = "The name of the tenant"
  default     = "test-tenant-1"
}
variable "tenant_domain" {
  type        = string
  description = "The domain that will be used for this tenants resources"
  default     = "test-tenant-1.turnbros.app"
}