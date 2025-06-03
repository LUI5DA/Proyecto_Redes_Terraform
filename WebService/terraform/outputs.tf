output "vm0_ip" {
  value = azurerm_public_ip.vm0_public_ip.ip_address
}

output "vm1_ip" {
  value = azurerm_public_ip.vm1_public_ip.ip_address
}
