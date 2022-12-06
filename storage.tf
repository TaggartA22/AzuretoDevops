data "azurerm_storage_account" "storage" {
  name                     = "azurepipeline1"
  resource_group_name      = data.azurerm_resource_group.sandbox.name
  location                 = data.azurerm_resource_group.sandbox.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
data "azurerm_storage_container" "container" {
  name                  = "container1"
  storage_account_name  = data.azurerm_storage_account.storage.name
  container_access_type = "private"
}