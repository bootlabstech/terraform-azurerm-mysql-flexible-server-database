resource "azurerm_mysql_flexible_server" "example" {
  name                         = var.server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  administrator_login          = var.administrator_login
  administrator_password       = var.administrator_login_password
  backup_retention_days        = var.backup_retention_days
  create_mode                  = var.create_mode
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
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
resource "azurerm_mysql_database" "example" {
  name                = var.name
  resource_group_name = azurerm_mysql_flexible_server.example.resource_group_name
  server_name         = azurerm_mysql_flexible_server.example.name
  charset             = var.charset
  collation           = var.collation
}
# Network setting allows All Azure Services
resource "azurerm_mysql_flexible_server_firewall_rule" "example" {
  name                = "office"
  resource_group_name = azurerm_mysql_flexible_server.example.resource_group_name
  server_name         = azurerm_mysql_flexible_server.example.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}