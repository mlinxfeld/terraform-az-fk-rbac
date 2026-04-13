variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Resource group name for this example"
  type        = string
  default     = "fk-rg-reader"
}

variable "group_name_prefix" {
  description = "Prefix for the Entra ID group display name."
  type        = string
  default     = "fk-rg-readers"
}

variable "role_definition_name" {
  description = "Built-in Azure RBAC role to assign on the Resource Group scope."
  type        = string
  default     = "Reader"
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    project = "foggykitchen"
    module  = "terraform-az-fk-rbac"
    example = "03_group_to_resource_group_reader"
    env     = "dev"
  }
}
