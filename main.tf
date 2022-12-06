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

resource "azurerm_virtual_network" "vmvnet" {
  name                = "vm-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.sandbox.location
  resource_group_name = data.azurerm_resource_group.sandbox.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "internal"
  resource_group_name  = data.azurerm_resource_group.sandbox.name
  virtual_network_name = azurerm_virtual_network.vmnet.name
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

resource "azurerm_windows_virtual_machine" "virtmachine" {
  name                = "virt-machine"
  resource_group_name = data.azurerm_resource_group.sandbox.name
  location            = data.azurerm_resource_group.sandbox.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.netinter.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}