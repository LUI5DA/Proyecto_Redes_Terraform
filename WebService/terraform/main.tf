###########################################
# main.tf - Basic infrastructure with NGINX
###########################################

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Configure Azure provider
provider "azurerm" {
  features {}
}

# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-nginx-setup"
  location = var.location
}

# Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-nginx"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet-nginx"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create Public IP for Load Balancer
resource "azurerm_public_ip" "lb_public_ip" {
  name                = "lb-public-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Basic"
}

# Create Availability Set for VM redundancy
resource "azurerm_availability_set" "nginx_avset" {
  name                         = "nginx-avset"
  location                     = azurerm_resource_group.rg.location
  resource_group_name          = azurerm_resource_group.rg.name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed                      = true
}

# Create Load Balancer
resource "azurerm_lb" "nginx_lb" {
  name                = "lb-nginx"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Basic"

  frontend_ip_configuration {
    name                 = "frontendConfig"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

# Create Backend Address Pool for Load Balancer
resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name            = "backend-pool"
  loadbalancer_id = azurerm_lb.nginx_lb.id
}

# Create HTTP Health Probe for Load Balancer
resource "azurerm_lb_probe" "http_probe" {
  name                = "http-probe"
  loadbalancer_id     = azurerm_lb.nginx_lb.id
  protocol            = "Http"
  port                = 80
  request_path        = "/"
}

# Create HTTPS Health Probe for Load Balancer
resource "azurerm_lb_probe" "https_probe" {
  name                = "https-probe"
  loadbalancer_id     = azurerm_lb.nginx_lb.id
  protocol            = "Tcp"
  port                = 443
}

# Create Load Balancer Rule for HTTP (port 80)
resource "azurerm_lb_rule" "http_rule" {
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.nginx_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "frontendConfig"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool.id]
  probe_id                       = azurerm_lb_probe.http_probe.id
}

# Create Load Balancer Rule for HTTPS (port 443)
resource "azurerm_lb_rule" "https_rule" {
  name                           = "https-rule"
  loadbalancer_id                = azurerm_lb.nginx_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = "frontendConfig"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool.id]
  probe_id                       = azurerm_lb_probe.https_probe.id
}

# Create Network Interfaces for the VMs
resource "azurerm_network_interface" "nic" {
  count               = 2
  name                = "nic-nginx-${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Associate NICs with Load Balancer Backend Pool
resource "azurerm_network_interface_backend_address_pool_association" "nic_assoc" {
  count                   = 2
  network_interface_id    = azurerm_network_interface.nic[count.index].id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
}

# Create NSG with HTTP, HTTPS, and SSH rules
resource "azurerm_network_security_group" "nginx_nsg" {
  name                = "nginx-vm-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTPS"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Associate NSG to NICs
resource "azurerm_network_interface_security_group_association" "nic_nsg_assoc" {
  count                     = 2
  network_interface_id      = azurerm_network_interface.nic[count.index].id
  network_security_group_id = azurerm_network_security_group.nginx_nsg.id
}

# NAT Rule to forward SSH to VM0 via port 5001
resource "azurerm_lb_nat_rule" "ssh_nat_rule_vm0" {
  name                           = "ssh-nat-vm0"
  resource_group_name            = azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.nginx_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 5001
  backend_port                   = 22
  frontend_ip_configuration_name = "frontendConfig"
}

# NAT Rule to forward SSH to VM1 via port 5002
resource "azurerm_lb_nat_rule" "ssh_nat_rule_vm1" {
  name                           = "ssh-nat-vm1"
  resource_group_name            = azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.nginx_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 5002
  backend_port                   = 22
  frontend_ip_configuration_name = "frontendConfig"
}

# Associate NAT Rule for VM0
resource "azurerm_network_interface_nat_rule_association" "vm0_nat_assoc" {
  network_interface_id  = azurerm_network_interface.nic[0].id
  ip_configuration_name = "ipconfig1"
  nat_rule_id           = azurerm_lb_nat_rule.ssh_nat_rule_vm0.id
}

# Associate NAT Rule for VM1
resource "azurerm_network_interface_nat_rule_association" "vm1_nat_assoc" {
  network_interface_id  = azurerm_network_interface.nic[1].id
  ip_configuration_name = "ipconfig1"
  nat_rule_id           = azurerm_lb_nat_rule.ssh_nat_rule_vm1.id
}

# Create Linux Virtual Machines (Ubuntu)
resource "azurerm_linux_virtual_machine" "nginx_vm" {
  count               = 2
  name                = "vm-nginx-${count.index}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1ms"
  admin_username      = var.admin_username
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  availability_set_id = azurerm_availability_set.nginx_avset.id

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
