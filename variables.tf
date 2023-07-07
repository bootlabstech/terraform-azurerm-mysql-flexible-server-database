
# variable "keyvault_name" {
#   type        = string
#   description = "The name of the Keyvault where the DB credentials are stored"

# }
variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the MySQL Flexible Server should exist"

}
variable "location" {
  type        = string
  description = "The Azure Region where the MySQL Flexible Server should exist"

}
variable "name" {
  type        = string
  description = "The name which should be used for this MySQL Flexible Server."

}
variable "administrator_login" {
  type        = string
  description = "The Administrator login for the MySQL Flexible Server. Required when create_mode is Default"
  # default = "user01"

}
variable "backup_retention_days" {
  type        = number
  description = " The backup retention days for the MySQL Flexible Server. Possible values are between 1 and 35 days. Defaults to 7"
  default = 7

}
variable "create_mode" {
  type        = string
  description = "The creation mode which can be used to restore or replicate existing servers. Possible values are Default, PointInTimeRestore, GeoRestore, and Replica"
  default = "Default"

}
variable "geo_redundant_backup_enabled" {
  type        = bool
  description = "Should geo redundant backup enabled? Defaults to false"
  default = false

}
variable "sku_name" {
  type        = string
  description = "sku_name should start with SKU tier B (Burstable), GP (General Purpose), MO (Memory Optimized) like B_Standard_B1s"

}
variable "mysql_version" {
  type        = string
  description = "The version of the MySQL Flexible Server to use. Possible values are 5.7, and 8.0.21."
  default = "8.0.21"

}
variable "zone" {
  type        = string
  description = "Specifies the Availability Zone in which this MySQL Flexible Server should be located. Possible values are 1, 2 and 3."
  default = "1"
}
# variable "replication_role" {
#   type        = string
#   description = "value"
#   default = "None"

# }

# variable "storage" {
#   type        = bool
#   description = "value"
#   default = false

# }
# variable "high_availability" {
#   type        = bool
#   description = "value"
#   default = true

# }
# variable "maintenance_window" {
#   type        = bool
#   description = "value"
#   default = true

# }
