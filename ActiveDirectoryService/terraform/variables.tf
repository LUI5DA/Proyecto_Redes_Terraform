variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "Azure Region where the infraestructure will be depoyed"
}

variable "vm_name" {
  description = "VM's name"
  type        = string
  default     = "winvm01"
}

variable "vm_size" {
  description = "VM's size"
  type        = string
  default     = "Standard_B2ms"
}

variable "admin_username" {
  description = "VM's Administrator user"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Administrator's password (at least 12 characters)"
  type        = string
  sensitive   = true
}
