terraform {
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = ">= 3.72.0"
    }
    tls = {
      source  = "registry.terraform.io/hashicorp/tls"
      version = ">= 3.0.0"
    }
    kubernetes = {
      source  = "registry.terraform.io/hashicorp/kubernetes"
      version = ">= 2.10.0"
    }
    cloudinit = {
      source  = "registry.terraform.io/hashicorp/cloudinit"
      version = ">= 2.0.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = "decro"
}

provider "tls" {}

provider "kubernetes" {}

provider "cloudinit" {}
