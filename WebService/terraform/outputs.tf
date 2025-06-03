# Public IP of the Load Balancer (for DNS & SSL setup)
output "load_balancer_public_ip" {
  value = azurerm_public_ip.lb_public_ip.ip_address
  description = "The public IP address of the load balancer"
}

# VM0 name and private IP (optional)
output "vm0_name" {
  value = azurerm_linux_virtual_machine.nginx_vm[0].name
  description = "The name of VM0"
}

output "vm1_name" {
  value = azurerm_linux_virtual_machine.nginx_vm[1].name
  description = "The name of VM1"
}

# SSH NAT Ports for each VM (used by Ansible over LB)
output "vm0_ssh_port" {
  value = azurerm_lb_nat_rule.ssh_nat_rule_vm0.frontend_port
  description = "NAT port used to SSH into VM0"
}

output "vm1_ssh_port" {
  value = azurerm_lb_nat_rule.ssh_nat_rule_vm1.frontend_port
  description = "NAT port used to SSH into VM1"
}
