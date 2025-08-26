infrastructure = {
    workload_subscription_id            = ""
    service_name                        = ""
    EAICODE                             = ""
    env_name                            = "NP"                 # NP, PR
    zone_grp                            = "az01"                # az01, az02, az03
    location                            = "koreacentral"
    vnet_network_cidr                   = ""     # /23, /24, 0/25, 128/25
    firewallGatewayIP                   = "10.241.4.132"
    dns_server_ip                       = ["10.241.0.148"]


}

postgreflexdbserver = {
    "서버" = {
        postgres_administrator_login    = "서버admin"
        postgres_version                = "16"

        # SKU 표준: Dev (B_Standard_B2s), PRD (GP_Standard_D4ds_v5)
        # Application용도에 따라 변경 가능
        postgres_sku_name               = "B_Standard_B2s"
    
        # Storage 표준: (32768, P4), (131072, P10)
        postgres_storage_mb             = 32768       # 32GB
        postgres_storage_tier           = "P4"      # IOPS 120

        # 설정기준 : az01 (1), az02 (2), az03 (3)
        postgres_zone                   = "1"

        # Backup 설정은 최대
        backup_retention_days               = 35
        geo_redundant_backup_enabled        = false

        # 설정기준 : Samezone, ZoneRedundant
        enable_high_availability            = false
        postgres_high_availability_mode     = "Samezone"
        postgres_standby_availability_zone  = "1"

      
    }
}
