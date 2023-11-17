terraform {
  required_version = ">= 0.13.3"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.6.2"
    }
  }
}
provider "google" {
  credentials = file("~/.config/gcloud/application_default_credentials.json")
      project     = var.project_id
      region      = var.region
}

module "cluster_vpc" {
  source = "./modules/vpc"
  project_id = var.project_id
}

module "service_account" {
    source = "./modules/service_account"
    project_id = var.project_id
}

module "cluster" {
  source = "./modules/cluster"
  project_id = var.project_id
  network_name                   = module.cluster_vpc.network_name
  subnets_name                   = module.cluster_vpc.subnets_name
  service_account_email           = module.service_account.email
  depends_on = [ module.cluster_vpc, module.service_account ]
}