resource "azuread_group" "readers" {
  display_name     = "${var.group_name_prefix}-${random_string.suffix.result}"
  security_enabled = true
}
