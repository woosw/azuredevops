locals {
    resource_group_name = lower(format("rg-%s-%s-%s-%s-%02d", var.infrastructure.zone_grp, var.infrastructure.service_code, var.infrastructure.env_name, var.infrastructure.service_name, var.infrastructure.rg_seq_no))
    vnet_name           = lower(format("vnet-%s-%s-%s-%02d", var.infrastructure.zone_grp, var.infrastructure.env_name, var.infrastructure.service_name, var.infrastructure.vnet_config.vnet_seq_no))
    vnet_id             = "/subscriptions/${var.infrastructure.workload_subscription_id}/resourceGroups/${local.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${local.vnet_name}"
    app_subnet_name     = lower("sbn-${var.infrastructure.zone_grp}-${var.infrastructure.env_name}-${var.infrastructure.service_name}-app")
    appgw_subnet_name   = lower("sbn-${var.infrastructure.zone_grp}-${var.infrastructure.env_name}-${var.infrastructure.service_name}-appgw")
    db_subnet_name      = lower("sbn-${var.infrastructure.zone_grp}-${var.infrastructure.env_name}-${var.infrastructure.service_name}-db")
    etc_subnet_name     = lower("sbn-${var.infrastructure.zone_grp}-${var.infrastructure.env_name}-${var.infrastructure.service_name}-etc")
    lb_subnet_name      = lower("sbn-${var.infrastructure.zone_grp}-${var.infrastructure.env_name}-${var.infrastructure.service_name}-lb")
    pe_subnet_name      = lower("sbn-${var.infrastructure.zone_grp}-${var.infrastructure.env_name}-${var.infrastructure.service_name}-pe")
    app_subnet_id       = "/subscriptions/${var.infrastructure.workload_subscription_id}/resourceGroups/${local.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${local.vnet_name}/subnets/${local.app_subnet_name}"
    appgw_subnet_id     = "/subscriptions/${var.infrastructure.workload_subscription_id}/resourceGroups/${local.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${local.vnet_name}/subnets/${local.appgw_subnet_name}"
    db_subnet_id        = "/subscriptions/${var.infrastructure.workload_subscription_id}/resourceGroups/${local.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${local.vnet_name}/subnets/${local.db_subnet_name}"
    etc_subnet_id       = "/subscriptions/${var.infrastructure.workload_subscription_id}/resourceGroups/${local.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${local.vnet_name}/subnets/${local.etc_subnet_name}"
    lb_subnet_id        = "/subscriptions/${var.infrastructure.workload_subscription_id}/resourceGroups/${local.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${local.vnet_name}/subnets/${local.lb_subnet_name}"
    pe_subnet_id        = "/subscriptions/${var.infrastructure.workload_subscription_id}/resourceGroups/${local.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${local.vnet_name}/subnets/${local.pe_subnet_name}"
    app_udr_name        = lower("udr-${var.infrastructure.zone_grp}-${var.infrastructure.env_name}-${var.infrastructure.service_name}-app")
    app_udr_id          = "/subscriptions/${var.infrastructure.workload_subscription_id}/resourceGroups/${local.resource_group_name}/providers/Microsoft.Network/routeTables/${local.app_udr_name}"
}