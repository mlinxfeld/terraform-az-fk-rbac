output "vm_id" {
  description = "Virtual machine resource ID."
  value       = module.compute.vm_id
}

output "resource_group_name" {
  description = "Resource group name used by this example."
  value       = azurerm_resource_group.foggykitchen_rg.name
}

output "vm_name" {
  description = "Virtual machine name."
  value       = var.vm_name
}

output "vm_private_ip" {
  description = "VM private IP address."
  value       = module.compute.vm_private_ip
}

output "vm_principal_id" {
  description = "Principal ID of the VM managed identity."
  value       = module.compute.vm_principal_id
}

output "storage_account_name" {
  description = "Storage account name."
  value       = module.storage.storage_account_name
}

output "storage_account_id" {
  description = "Storage account resource ID."
  value       = module.storage.storage_account_id
}

output "primary_blob_endpoint" {
  description = "Primary blob endpoint."
  value       = module.storage.primary_blob_endpoint
}

output "storage_primary_access_key" {
  description = "Storage account primary access key for optional validation from the operator workstation."
  value       = module.storage.primary_access_key
  sensitive   = true
}

output "container_names" {
  description = "Created blob container names."
  value       = module.storage.container_names
}

output "role_assignment_id" {
  description = "Role assignment ID created by the RBAC module."
  value       = module.rbac.role_assignment_id
}
