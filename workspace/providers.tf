terraform {
  # TF_HTTP_ADDRESS
  # TF_HTTP_LOCK_ADDRESS
  # TF_HTTP_UNLOCK_ADDRESS
  backend "http" {}
}

provider "kubernetes" {
  host                   = var.kube_host
  cluster_ca_certificate = base64decode(var.kube_cluster_ca_cert)
  client_key             = base64decode(var.kube_client_key)
  client_certificate     = base64decode(var.kube_client_cert)
}

variable "kube_host" {}
variable "kube_cluster_ca_cert" {}
variable "kube_client_key" {}
variable "kube_client_cert" {}