module "lz_posgreflexdbserver" {
    providers = {
        azurerm                               = azurerm
    }
# INFRASTRUCTURE
    workload_subscription_id                = var.infrastructure.workload_subscription_id
    location                                = var.infrastructure.location
    service_code                            = var.infrastructure.service_code
    service_grade                           = var.infrastructure.service_grade
    service_name                            = var.infrastructure.service_name
    env_name                                = var.infrastructure.env_name
    zone_grp                                = var.infrastructure.zone_grp
    # OUTPUT FROM INFRASTRUCTURE
    resource_group_name                     = local.resource_group_name
    subnet_id                               = local.db_subnet_id
    
    source                                    = "../../module/postgressql/server"
    
    # POSTGRES SQL FLEX (LOOP)
    for_each                                = var.create_modules.postgreflexdbserver ? var.postgreflexdbserver : {}
    postgres_sku_name                       = each.value.postgres_sku_name
    db_seq_no                               = each.value.db_seq_no
    postgres_storage_tier                   = each.value.postgres_storage_tier
    postgres_storage_mb                     = each.value.postgres_storage_mb
    identity                                = each.value.identity
    high_availability                       = each.value.high_availability
    customer_managed_key                    = each.value.customer_managed_key
    postgres_administrator_login            = each.value.postgres_administrator_login
    postgres_administrator_password         = each.value.postgres_administrator_password
    postgres_version                        = each.value.postgres_version
    postgres_zone                           = each.value.postgres_zone
    backup_retention_days                   = each.value.backup_retention_days
    geo_redundant_backup_enabled            = each.value.geo_redundant_backup_enabled
    # TAGS
    common_tags                             = local.common_tags
}
