output "resource_group_name" {
  description = "Resource group name used by this example."
  value       = azurerm_resource_group.foggykitchen_rg.name
}

output "resource_group_id" {
  description = "Resource group ID used as the RBAC scope."
  value       = azurerm_resource_group.foggykitchen_rg.id
}

output "group_display_name" {
  description = "Display name of the Entra ID security group."
  value       = azuread_group.readers.display_name
}

output "group_object_id" {
  description = "Object ID of the Entra ID security group used as the RBAC principal."
  value       = azuread_group.readers.object_id
}

output "role_definition_name" {
  description = "Role assigned by this example."
  value       = var.role_definition_name
}

output "role_assignment_id" {
  description = "Role assignment ID created by the RBAC module."
  value       = module.rbac.role_assignment_id
}
