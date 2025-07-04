output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "windows_vm_public_ip" {
  description = "Windows VM's public IP Address"
  value       = azurerm_public_ip.windows_vm_ip.ip_address
}
