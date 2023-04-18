# Creates a Flexible MySQL Server
resource "azurerm_mysql_flexible_server" "example" {
  for_each= { for i in var.server_set : i.name => i }
  name                         = each.value.name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  administrator_login          = each.value.administrator_login
  administrator_password       = each.value.administrator_login_password
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