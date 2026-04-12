variable "scope" {
  description = "The scope at which the role assignment applies (e.g. Storage Account ID)"
  type        = string
}

variable "principal_id" {
  description = "The principal ID of the identity (e.g. VM Managed Identity)"
  type        = string
}

variable "role_definition_name" {
  description = "The name of the role to assign (e.g. Storage Blob Data Reader)"
  type        = string
}