terraform {
  required_version = ">= 1.7.5"

  backend "azurerm" {
    # DO NOT put values here
    # They will be injected by Azure DevOps pipeline
  }
}

provider "azurerm" {
  features {}
}
