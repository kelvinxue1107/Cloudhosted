terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.3.0" // [4]
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" // [13]
    }
    alicloud = {
      source  = "aliyun/alicloud"
      version = "~> 1.226.0" // [5]
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0" // [50]
    }
    ansible = {
      source  = "ansible/ansible"
      version = "~> 1.2.0" // [20]
    }
  }
}