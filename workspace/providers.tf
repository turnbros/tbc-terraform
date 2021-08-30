provider "kubernetes" {
  host                   = var.kube_host
  cluster_ca_certificate = base64decode(var.kube_cluster_ca_cert)
  client_key             = base64decode(var.kube_client_key)
  client_certificate     = base64decode(var.kube_client_cert)
}