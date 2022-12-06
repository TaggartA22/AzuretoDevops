#terraform to be be init/applied/deleted
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.34.0"
    }
  }
}

provider "azurerm" {
    features {}
}

data "azurerm_resource_group" "sandbox" {
  name = "taggarta-sandbox-rg"
  location = "UK South"
}
