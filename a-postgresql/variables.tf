variable "infrastructure" {
    type = object({
        DPCCODE                                         = string
        EAICODE                                         = number
        ENV                                             = string
        TENANT                                          = string

        workload_subscription_id                        = string
        infra_subscription_id                           = optional(string, "64061f25-366b-47a8-af8b-74a88656fbb2")
        service_name                                    = string
        zone_grp                                        = string
        env_name                                        = string
        service_code                                    = string
        service_grade                                   = string
        location                                        = string
        dns_server_ip                                   = optional(list(string), ["10.241.0.148"])
        central_dns_zone_resource_group                 = optional(string, "rg-az01-co013601-azgov-network-01")
        vnet_config                                     = object({
            vnet_seq_no                                 = number
            bgp_community                               = optional(string)
        })  
        dns_server                                      = optional(string, "Central")
        vnet_network_cidr                               = string
        default_outbound_access_enabled                 = optional(bool, true)
        private_endpoint_network_policies               = optional(string, "RouteTableEnabled")
        firewallGatewayIP                               = optional(string, "10.241.4.132")
        virtual_hub_id                                  = optional(string, "/subscriptions/64061f25-366b-47a8-af8b-74a88656fbb2/resourceGroups/rg-az01-co013601-azgov-network-01/providers/Microsoft.Network/virtualHubs/vhub-az01-azgov-01")
        internet_security_enabled                       = optional(bool, true)
        infra_keyvault_resource_group                   = optional(string, "rg-az01-co013601-azgov-infra-01")
        infra_keyvault_name                             = optional(string, "kv-az01-azgov-01")
    })
}

variable "postgreflexdbserver" {
  type = map(object({
        postgres_version                                = optional(string, "16")
        postgres_administrator_login                    = optional(string)
        postgres_administrator_password                 = optional(string)
        postgres_zone                                   = optional(string) 
        postgres_storage_mb                             = string
        postgres_storage_tier                           = string
        postgres_sku_name                               = string
        dns_record_ttl                                  = optional(number, 10)
        authentication = optional(object({
            active_directory_auth_enabled               = optional(bool, null)
            password_auth_enabled                       = optional(bool, null)
            tenant_id                                   = optional(string, null)
        }))
        backup_retention_days                           = optional(number, 7)
        geo_redundant_backup_enabled                    = optional(bool, false)
        create_mode                                     = optional(string, "Default")

        customer_managed_key = optional(object({
            key_vault_key_id                            = optional(string)
            primary_user_assigned_identity_id           = optional(string)
            geo_backup_key_vault_key_id                 = optional(string)
            geo_backup_user_assigned_identity_id        = optional(string)
        }))

        identity = optional(object({
            type                                        = optional(string)
            identity_ids                                = optional(string)
        }))

        enable_high_availability                        = optional(bool)
        high_availability = optional(object({
            mode                                        = optional(string)
            standby_availability_zone                   = optional(string)
        }))
    }))
}