# Define the Azure region where resources will be deployed
variable "location" {
  description = "Geographic location where Azure resources will be created."
  type        = string
  default     = "eastus"
}

# Define the admin username for virtual machines
variable "admin_username" {
  description = "Admin username for the virtual machines."
  type        = string
  default     = "azureuser"
}

# Define the local path to the SSH public key used for VM access
variable "ssh_public_key_path" {
  description = "Local path to the SSH public key file used for authentication with the virtual machines."
  type        = string
}
