output "azurerm_virtual_network_name" {
  value = azurerm_virtual_network.vnet.name
}

output "azurerm_subnet_name" {
  value = var.azurerm_subnet_name
}
