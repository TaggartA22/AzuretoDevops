resource "azurerm_virtual_network" "vmvnet" {
  name                = "vm-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.sandbox.location
  resource_group_name = data.azurerm_resource_group.sandbox.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "internal"
  resource_group_name  = data.azurerm_resource_group.sandbox.name
  virtual_network_name = azurerm_virtual_network.vmvnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "netinter" {
  name                = "net-inter"
  location            = data.azurerm_resource_group.sandbox.location
  resource_group_name = data.azurerm_resource_group.sandbox.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}