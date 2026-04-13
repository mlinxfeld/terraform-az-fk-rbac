module "aks" {
  source = "github.com/mlinxfeld/terraform-az-fk-aks"

  name                = var.aks_name
  location            = azurerm_resource_group.foggykitchen_rg.location
  resource_group_name = azurerm_resource_group.foggykitchen_rg.name

  create_networking    = true
  network_plugin       = var.network_plugin
  default_node_count   = var.default_node_count
  default_node_vm_size = var.default_node_vm_size

  tags = var.tags
}
