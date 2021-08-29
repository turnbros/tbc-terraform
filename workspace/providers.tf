terraform {
  # TF_HTTP_ADDRESS
  # TF_HTTP_LOCK_ADDRESS
  # TF_HTTP_UNLOCK_ADDRESS
  backend "http" {}
}

provider "kubernetes" {
  # KUBE_HOST
  # KUBE_TOKEN
  # KUBE_CLUSTER_CA_CERT_DATA
}