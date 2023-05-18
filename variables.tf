
variable "location" {
  type        = string
  description = "value"

}
variable "resource_group_name" {
  type        = string
  description = "value"

}
variable "backup_retention_days" {
  type        = number
  description = "value"
  default     = 35

}

variable "server_set" {
  type = list(object({
    administrator_login = string,
    name = string
    sku_name = string,
    mysql_version = string,
    create_mode = string,
    auto_grow_enabled = bool,
    backup_retention_days = number,
    size_gb = number,
    iops = number
  }))
  description = "value"


}
variable "keyvault_name" {
  type        = string
  description = "value"

}

