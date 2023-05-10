resource "azurerm_mysql_flexible_server" "example" {
  name                         = var.server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  administrator_login          = var.administrator_login
  administrator_password       = random_password.password.result
  backup_retention_days        = var.backup_retention_days
  create_mode                  = var.create_mode
  sku_name                     = var.sku_name
  version                      = var.mysql_version
  # identity {
  #   type = "SystemAssigned"
  # }
  # storage {
  #   auto_grow_enabled = 
  #   iops = 
  #   size_gb = 
  # }
  # high_availability {
  #   mode = 
  #   standby_availability_zone =     
  # }
  # maintenance_window {
  #   day_of_week = 
  #   start_hour = 
  #   start_minute = 
  # }

}
# Creates a Flexible MySQL database
# resource "azurerm_mysql_database" "example" {
#   name                = var.name
#   resource_group_name = azurerm_mysql_flexible_server.example.resource_group_name
#   server_name         = azurerm_mysql_flexible_server.example.name
#   charset             = var.charset
#   collation           = var.collation
# }
resource "random_password" "password" {
 length = 16
 special = true
}
resource "azurerm_key_vault_secret" "mysql_username" {
 name = "${var.name}-username"
 value = azurerm_mysql_flexible_server.example.administrator_login
 key_vault_id = data.azurerm_key_vault.key_vault.id

}


resource "azurerm_key_vault_secret" "mysql_password" {
 name  = "${var.name}-password"
 value = random_password.password.result
 key_vault_id = data.azurerm_key_vault.key_vault.id

}

data "azurerm_key_vault" "key_vault" {
 name  = var.keyvault_name
 resource_group_name = var.resource_group_name
}