variable "keyvault_name" {
  type        = string
  description = "The name of the Keyvault where the DB credentials are stored"

}
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

}
variable "backup_retention_days" {
  type        = number
  description = " The backup retention days for the MySQL Flexible Server. Possible values are between 1 and 35 days. Defaults to 7"
  default     = 7
}
variable "create_mode" {
  type        = string
  description = "The creation mode which can be used to restore or replicate existing servers. Possible values are Default, PointInTimeRestore, GeoRestore, and Replica"
  default     = "Default"
}
variable "geo_redundant_backup_enabled" {
  type        = bool
  description = "Should geo redundant backup enabled? Defaults to false"
  default     = false
}
variable "sku_name" {
  type        = string
  description = "sku_name should start with SKU tier B (Burstable), GP (General Purpose), MO (Memory Optimized) like B_Standard_B1s"
}
variable "mysql_version" {
  type        = string
  description = "The version of the MySQL Flexible Server to use. Possible values are 5.7, and 8.0.21."
  default     = "8.0.21"

}
variable "zone" {
  type        = string
  description = "Specifies the Availability Zone in which this MySQL Flexible Server should be located. Possible values are 1, 2 and 3."
  default     = "1"
}

# PE
# PE
# private endpoint

variable "private_endpoint_subnet_id" {
  type        = string
  description = "The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint."

}

variable "is_manual_connection" {
  type        = bool
  description = "Does the Private Endpoint require Manual Approval from the remote resource owner?"
  default     = false

}
variable "subresource_names" {
  type        = list(string)
  description = " A list of subresource names which the Private Endpoint is able to connect to."
  default     = ["mysqlServer"]
}
variable "private_dns_zone_ids" {
  type        = list(string)
  description = "Specifies the list of Private DNS Zones to include within the private_dns_zone_group."
}

variable "public_network_access" {
  type = bool
  description = "to enable public internet access"
  default = false
}





