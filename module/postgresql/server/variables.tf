variable "name" { 
    type = string 
    description = "The name of the PostgreSQL Flexible Server."
}

variable "resource_group_name" { 
    type = string 
}
variable "location" { 
    type = string 
}

variable "sku_name"       { 
    type = string 
}
variable "server_version" { 
    type = number 

} 
variable "zone"           { 
    type = number 
}
variable "storage_mb"     { 
    type = number  
    default = 32768 
}
variable "storage_tier"   { 
    type = string  
    default = "P6" 
}
variable "backup_retention_days"        { 
    type = number 
    default = 7 
}
variable "geo_redundant_backup_enabled" { 
    type = bool   
    default = false 
}

variable "create_mode" { 
    type = string  
    default = "Default"
    # "Default" | "PointInTimeRestore" | "GeoRestore" | "Replica"
}
variable "source_server_id" { 
    type = string  
    default = null 
    # PointInTimeRestore, GeoRestore, Replica 모드에서 사용
}
variable "point_in_time_restore_time_in_utc" { 
    type = string 
    default = null 
    # PointInTimeRestore 모드에서 사용, ISO 8601 형식
}

variable "administrator_login"    { 
    type = string 
    description = "The administrator login for the PostgreSQL Flexible Server."
    default = "회사에 정책과 맞게 지정"
}
variable "administrator_password" { 
    type = string 
    sensitive = true 
}

variable "ha" {
  type = object({
    mode                      = optional(string) # "ZoneRedundant" | "SameZone" | "Disabled"
    standby_availability_zone = optional(number)
  })
  default = { mode = "Disabled", standby_availability_zone = 1 }
}

variable "maintenance" {
  type = object({
    day_of_week  = number
    start_hour   = number
    start_minute = number
  })
  default = { day_of_week = 0, start_hour = 0, start_minute = 0 }
}

variable "public_network_access_enabled" { 
    type = bool 
    default = false 
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = list(string)
  })
  default = { type = "SystemAssigned", identity_ids = [] }
}

variable "server_configuration" {
  type    = map(string)
  default = {}
}

variable "tags" { 
    type = map(string) 
    default = {} 
}

variable "aad_admin" {
  type = object({
    tenant_id      = string
    object_id      = string
    principal_type = string
    principal_name = string
  })
  default = null
}


