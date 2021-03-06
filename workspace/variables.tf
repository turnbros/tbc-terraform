variable "kube_host" {}
variable "kube_cluster_ca_cert" {}
variable "kube_client_key" {}
variable "kube_client_cert" {}

variable "tbc_api_endpoint" {
  type        = string
  description = "The API endpoint for TBC"
}
variable "tenant_name" {
  type        = string
  description = "The name of the tenant"
}
variable "tenant_domain" {
  type        = string
  description = "The domain that will be used for this tenants resources"
}