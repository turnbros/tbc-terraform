terraform {
  backend "http" {}
  required_version = ">= 1.0.5"
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}