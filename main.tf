# Creates a Flexible MySQL Server
resource "azurerm_mysql_flexible_server" "example" {
  resource_group_name            = var.resource_group_name
  location                       = var.location
  name                           = var.name
  administrator_login            = var.administrator_login
  administrator_password         = var.password
  backup_retention_days          = var.backup_retention_days
  create_mode                    = var.create_mode  
  geo_redundant_backup_enabled   = var.geo_redundant_backup_enabled
  sku_name                       = var.sku_name
  version                        = var.mysql_version
  zone                           = var.zone

}
resource "azurerm_mysql_flexible_server_firewall_rule" "firewall_rule" {
  name  = "${var.name}-firewallrule"
  resource_group_name = var.resource_group_name
  server_name = var.name
  start_ip_address = "0.0.0.0"
  end_ip_address  = "0.0.0.0"
    
    depends_on = [ azurerm_mysql_flexible_server.example ]
}
# # get key vault details to store DB password as secret
# data "azurerm_key_vault" "key_vault" {
#   name  = var.keyvault_name
#   resource_group_name = var.resource_group_name
# }

# # Creates a Flexible MySQL Server
# resource "azurerm_mysql_flexible_server" "example" {
#   resource_group_name            = var.resource_group_name
#   location                       = var.location
#   name                           = var.name
#   administrator_login            = var.administrator_login
#   administrator_password         = random_password.password.result
#   backup_retention_days          = var.backup_retention_days
#   create_mode                    = var.create_mode  
#   geo_redundant_backup_enabled   = var.geo_redundant_backup_enabled
#   sku_name                       = var.sku_name
#   version                        = var.mysql_version
#   zone                           = var.zone
#   # replication_role               = var.replication_role
#   # delegated_subnet_id          = var.
#   # private_dns_zone_id          = var.


#   # dynamic "storage" {
#   #   for_each = var.storage ? [{}] : []
#   #    content {
#   #     auto_grow_enabled = var.auto_grow_enabled
#   #     iops = var.iops
#   #     size_gb = var.size_gb
#   #    }
#   # }
#   # dynamic "high_availability" {
#   #   for_each = var.high_availability ? [{}] : []
#   #    content {
#   #     mode = var.mode
#   #     standby_availability_zone = var.standby_availability_zone
#   #    }
#   # }
#   # dynamic "maintenance_window" {
#   #   for_each = var.maintenance_window ? [{}] : []
#   #    content {
#   #     day_of_week = var.day_of_week
#   #     start_hour = var.start_hour
#   #     start_minute = var.start_minute
#   #    }
#   # }

# }


# # Allows all Azure service access the db
# resource "azurerm_mysql_flexible_server_firewall_rule" "firewall_rule" {
#   name  = "${var.name}-firewallrule"
#   resource_group_name = var.resource_group_name
#   server_name = var.name
#   start_ip_address = "0.0.0.0"
#   end_ip_address  = "0.0.0.0"
    
#     depends_on = [ azurerm_mysql_flexible_server.example ]
# }


# resource "random_password" "password" {
#   length      = 12
#   lower       = true
#   min_lower   = 6
#   min_numeric = 2
#   min_special = 2
#   min_upper   = 2
#   numeric     = true
#   special     = true
#   upper       = true


# }

# # Stores DB login password as keyvault secret
# resource "azurerm_key_vault_secret" "mysql_password" {
#     name = "${var.name}-password"
#     value = random_password.password.result
#     key_vault_id = data.azurerm_key_vault.key_vault.id
    
#     depends_on = [ azurerm_mysql_flexible_server.example ]
# }