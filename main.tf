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
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.22.0"
    }
  }
}