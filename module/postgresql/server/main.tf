terraform {
  required_version = ">= 1.5.0, < 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.110"
    }
  }
}

resource "azurerm_postgresql_flexible_server" "pgserver" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku_name       = var.sku_name
  version        = var.server_version
  zone           = var.zone
  storage_mb     = var.storage_mb
  storage_tier   = var.storage_tier
  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  create_mode                  = var.create_mode
  source_server_id             = var.source_server_id
  point_in_time_restore_time_in_utc = var.point_in_time_restore_time_in_utc

  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password

  high_availability {
    mode                      = var.ha.mode
    standby_availability_zone = var.ha.standby_availability_zone
  }

  maintenance_window {
    day_of_week  = var.maintenance.day_of_week
    start_hour   = var.maintenance.start_hour
    start_minute = var.maintenance.start_minute
  }

  public_network_access_enabled = var.public_network_access_enabled

  identity {
    type         = var.identity.type          # "SystemAssigned" | "UserAssigned" | "SystemAssigned, UserAssigned"
    identity_ids = var.identity.identity_ids
  }

  tags = var.tags
}

# (옵션) Azure AD Admin
resource "azurerm_postgresql_flexible_server_active_directory_administrator" "aad_admin" {
  count               = var.aad_admin == null ? 0 : 1
  server_name         = azurerm_postgresql_flexible_server.pgserver.name
  resource_group_name = var.resource_group_name

  tenant_id      = var.aad_admin.tenant_id
  object_id      = var.aad_admin.object_id
  principal_type = var.aad_admin.principal_type # "User" | "Group" | "ServicePrincipal"
  principal_name = var.aad_admin.principal_name
}

# (옵션) 서버 구성(파라미터)
resource "azurerm_postgresql_flexible_server_configuration" "cfg" {
  for_each = var.server_configuration
  name     = each.key
  server_id = azurerm_postgresql_flexible_server.pgserver.id
  value    = each.value
}

output "id"    { value = azurerm_postgresql_flexible_server.pgserver.id }
output "name"  { value = azurerm_postgresql_flexible_server.pgserver.name }
output "fqdn"  { value = azurerm_postgresql_flexible_server.pgserver.fqdn }


# backup

