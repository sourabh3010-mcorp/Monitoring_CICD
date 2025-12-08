terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.80.0"   # Example: latest at this writing
    }
  }

  required_version = ">= 1.7.5"
}

provider "azurerm" {
  features {}
}
