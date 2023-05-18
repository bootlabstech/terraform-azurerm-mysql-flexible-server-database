# get key vault details
data "azurerm_key_vault" "key_vault" {
  name  = var.keyvault_name
  resource_group_name = var.resource_group_name
}

# Creates a Flexible MySQL Server
resource "azurerm_mysql_flexible_server" "example" {
  for_each= { for i in var.server_set : i.name => i }
    resource_group_name          = var.resource_group_name
    location                     = var.location
    name                         = each.value.name
    administrator_login          = each.value.administrator_login
    administrator_password       = random_password.password[each.key].result
    backup_retention_days        = each.value.backup_retention_days
    create_mode                  = each.value.create_mode  
    sku_name                     = each.value.sku_name
    version                      = each.value.mysql_version

    storage {
      auto_grow_enabled = each.value.auto_grow_enabled
      iops = each.value.iops
      size_gb = each.value.size_gb
    }

    depends_on = [ random_password.password ]

}


# Allows all Azure service access the db
resource "azurerm_mysql_flexible_server_firewall_rule" "firewall_rule" {
  for_each= { for i in var.server_set : i.name => i }
  
    name  = "${each.value.name}-rule"
    resource_group_name = var.resource_group_name
    server_name = each.value.name
    start_ip_address = "0.0.0.0"
    end_ip_address  = "0.0.0.0"
    
    depends_on = [ azurerm_mysql_flexible_server.example ]
}


# Generate random value for the login password

resource "random_password" "password" {
  for_each= { for i in var.server_set : i.name => i }
    length = 8
    lower = true
    min_lower = 1
    min_numeric= 1
    min_special= 1
    min_upper= 1
    numeric = true
    override_special = "_"
    special = true
    upper = true
    

}

# saves login password as keyvault secret
resource "azurerm_key_vault_secret" "mysql_password" {
  for_each= { for i in var.server_set : i.name => i }
    name = each.value.name
    value = random_password.password[each.key].result
    key_vault_id = azurerm_key_vault.key_vault.id
    
    depends_on = [ azurerm_mysql_flexible_server.example ]
}