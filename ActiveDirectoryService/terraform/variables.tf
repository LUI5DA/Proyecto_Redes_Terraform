variable "resource_group_name" {
  type        = string
  description = "Nombre del grupo de recursos"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "Región de Azure donde se desplegará la infraestructura"
}

variable "vm_name" {
  description = "Nombre de la máquina virtual"
  type        = string
  default     = "winvm01"
}

variable "vm_size" {
  description = "Tamaño de la VM"
  type        = string
  default     = "Standard_B2ms"
}

variable "admin_username" {
  description = "Usuario administrador de la VM"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Contraseña del administrador (mínimo 12 caracteres)"
  type        = string
  sensitive   = true
}
