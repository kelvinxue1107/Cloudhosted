# /environments/prod/backend.tf
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-central"
    storage_account_name = "sttfstatecentralprod"
    container_name       = "tfstate"
    key                  = "prod.v2ray.multi-cloud.tfstate"
  }
}