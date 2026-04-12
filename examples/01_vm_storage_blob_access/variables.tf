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

variable "vnet_name" {
  description = "Virtual network name"
  type        = string
  default     = "fk-vnet"
}

variable "vm_name" {
  description = "Virtual machine name"
  type        = string
  default     = "fk-storage-client-vm"
}

variable "storage_name_prefix" {
  description = "Prefix for storage account name (lowercase letters and numbers only)."
  type        = string
  default     = "fksa"

  validation {
    condition     = can(regex("^[a-z0-9]+$", var.storage_name_prefix)) && length(var.storage_name_prefix) <= 10
    error_message = "storage_name_prefix must be lowercase letters/numbers only and max 10 chars."
  }
}

variable "vnet_address_space" {
  description = "VNet CIDR"
  type        = string
  default     = "10.10.0.0/16"
}

variable "subnets" {
  description = "Subnet map for the example virtual network"
  type = map(object({
    address_prefixes = list(string)
  }))

  default = {
    fk-subnet = {
      address_prefixes = ["10.10.0.0/24"]
    }
  }
}

variable "admin_username" {
  description = "Linux admin username"
  type        = string
  default     = "azureuser"
}

variable "vm_size" {
  description = "VM size"
  type        = string
  default     = "Standard_B1s"
}

variable "account_tier" {
  description = "Storage account tier."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Storage replication type."
  type        = string
  default     = "LRS"
}

variable "account_kind" {
  description = "Storage account kind."
  type        = string
  default     = "StorageV2"
}

variable "access_tier" {
  description = "Storage access tier."
  type        = string
  default     = "Hot"
}

variable "containers" {
  description = "Blob containers to create in the storage account."
  type = map(object({
    access_type = optional(string, "private")
    metadata    = optional(map(string), {})
  }))

  default = {
    logs = {
      access_type = "private"
      metadata = {
        purpose = "logs"
      }
    }
    artifacts = {
      access_type = "private"
    }
  }
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    project = "foggykitchen"
    module  = "terraform-az-fk-rbac"
    example = "01_vm_storage_blob_access"
    env     = "dev"
  }
}
