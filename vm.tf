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