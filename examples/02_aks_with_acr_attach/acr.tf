module "acr" {
  source = "github.com/mlinxfeld/terraform-az-fk-acr"

  acr_name            = "${var.acr_name_prefix}${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.foggykitchen_rg.name
  location            = azurerm_resource_group.foggykitchen_rg.location

  sku                           = var.acr_sku
  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled

  tags = var.tags
}
