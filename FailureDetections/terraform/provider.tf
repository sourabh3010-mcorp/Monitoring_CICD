terraform {
  required_version = ">= 1.7.5"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.80.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}
