# single server
# resource "azurerm_mysql_flexible_server" "example" {
#   name                         = var.server_name
#   resource_group_name          = var.resource_group_name
#   location                     = var.location
#   administrator_login          = var.administrator_login
#   administrator_password       = var.administrator_login_password
#   backup_retention_days        = var.backup_retention_days
#   create_mode                  = var.create_mode
#   geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
#   sku_name                     = var.sku_name
#   version                      = var.mysql_version
#   # identity {
#   #   type = "SystemAssigned"
#   # }
#   # storage {
#   #   auto_grow_enabled = 
#   #   iops = 
#   #   size_gb = 
#   # }
#   # high_availability {
#   #   mode = 
#   #   standby_availability_zone =     
#   # }
#   # maintenance_window {
#   #   day_of_week = 
#   #   start_hour = 
#   #   start_minute = 
#   # }

# }
# # Creates a Flexible MySQL database
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
# Creates a list of Flexible MySQL Server
resource "azurerm_mysql_flexible_server" "example" {
  for_each= { for i in var.server_set : i.name => i }
  name                         = each.value.name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  administrator_login          = each.value.administrator_login
  administrator_password       = random_password.password.result
  backup_retention_days        = each.value.backup_retention_days
  create_mode                  = each.value.create_mode
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  sku_name                     = each.value.sku_name
  version                      = each.value.mysql_version
  # identity {
  #   type = "SystemAssigned"
  # }
  storage {
    auto_grow_enabled = each.value.auto_grow_enabled
    iops = each.value.iops
    size_gb = each.value.size_gb
  }
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
# Network setting allows All Azure Services
resource "azurerm_mysql_flexible_server_firewall_rule" "example" {
  name                = "office"
  resource_group_name = azurerm_mysql_flexible_server.example.resource_group_name
  server_name         = azurerm_mysql_flexible_server.example.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}