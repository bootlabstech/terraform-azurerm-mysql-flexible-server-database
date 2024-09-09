# Creates a Flexible MySQL Server
resource "azurerm_mysql_flexible_server" "example" {
  resource_group_name          = var.resource_group_name
  location                     = var.location
  name                         = var.name
  administrator_login          = var.administrator_login
  administrator_password       = random_password.password.result
  backup_retention_days        = var.backup_retention_days
  create_mode                  = var.create_mode
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  sku_name                     = var.sku_name
  version                      = var.mysql_version
  zone                         = var.zone
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }

}

# # Allows all azure services to connect to the server
# resource "azurerm_mysql_flexible_server_firewall_rule" "firewall_rule" {
#   name                = "${var.name}-firewallrule"
#   resource_group_name = var.resource_group_name
#   server_name         = var.name
#   start_ip_address    = "0.0.0.0"
#   end_ip_address      = "0.0.0.0"

#   depends_on = [azurerm_mysql_flexible_server.example]
# }

# get key vault details to store DB password as secret
data "azurerm_key_vault" "key_vault" {
  name                = var.keyvault_name
  resource_group_name = var.resource_group_name
}

# Creates random password
resource "random_password" "password" {
  length      = 12
  lower       = true
  min_lower   = 6
  min_numeric = 2
  min_special = 2
  min_upper   = 2
  numeric     = true
  special     = true
  upper       = true

}

# Stores DB login password as keyvault secret
resource "azurerm_key_vault_secret" "mysql_password" {
  name         = "${var.name}-pwd"
  value        = random_password.password.result
  key_vault_id = data.azurerm_key_vault.key_vault.id

  depends_on = [azurerm_mysql_flexible_server.example]
}