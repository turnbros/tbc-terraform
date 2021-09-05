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
variable "nodeport_alias_name" {
  type        = string
  description = "The name of the Opnsense firewall alias the node ports need to be added to."
}
variable "nodeport_alias_uuid" {
  type        = string
  description = "The UUID that the tenant alias will be parented to."
}