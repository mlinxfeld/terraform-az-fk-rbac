variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Resource group name for this example"
  type        = string
  default     = "fk-rg"
}

variable "acr_name_prefix" {
  description = "Prefix for ACR name (lowercase letters and numbers only)."
  type        = string
  default     = "fkacr"

  validation {
    condition     = can(regex("^[a-z0-9]+$", var.acr_name_prefix)) && length(var.acr_name_prefix) <= 14
    error_message = "acr_name_prefix must be lowercase letters/numbers only and max 14 chars."
  }
}

variable "aks_name" {
  description = "AKS cluster name"
  type        = string
  default     = "fk-aks-acr"
}

variable "acr_sku" {
  description = "Azure Container Registry SKU"
  type        = string
  default     = "Basic"
}

variable "admin_enabled" {
  description = "Enable admin user for ACR"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Enable public network access for ACR"
  type        = bool
  default     = true
}

variable "network_plugin" {
  description = "AKS network plugin"
  type        = string
  default     = "kubenet"
}

variable "default_node_count" {
  description = "Default AKS node count"
  type        = number
  default     = 1
}

variable "default_node_vm_size" {
  description = "Default AKS node VM size"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    project = "foggykitchen"
    module  = "terraform-az-fk-rbac"
    example = "02_aks_with_acr_attach"
    env     = "dev"
  }
}
