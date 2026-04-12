module "rbac" {
  source = "../../"

  scope                = module.storage.storage_account_id
  principal_id         = module.compute.vm_principal_id
  role_definition_name = "Storage Blob Data Contributor"
}
