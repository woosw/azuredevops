variable "name" {
  description = "VNet 이름"
  type        = string
}

variable "location" {
  description = "리전"
  type        = string
}

variable "resource_group_name" {
  description = "리소스 그룹 이름"
  type        = string
}

variable "address_space" {
  description = "VNet 대역 (예: [\"10.10.0.0/16\"])"
  type        = list(string)
}

variable "dns_servers" {
  description = "사용자 정의 DNS 서버 목록"
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = <<EOT
서브넷 목록. 예:
[
  {
    name        = "snet-app"
    address_prefixes = ["10.10.1.0/24"]
    attach_nsg  = true
    delegations = [
      { name = "d1", service_name = "Microsoft.ContainerInstance/containerGroups" }
    ]
  },
  { name = "snet-db", address_prefixes = ["10.10.2.0/24"], attach_nsg = false }
]
EOT
  type = list(object({
    name                                   = string
    address_prefixes                       = list(string)
    attach_nsg                             = optional(bool)
    private_endpoint_network_policies_enabled     = optional(bool, true)
    private_link_service_network_policies_enabled = optional(bool)
    delegations = optional(list(object({
      name         = string
      service_name = string
      actions      = optional(list(string))
    })))
  }))
}

variable "create_nsg" {
  description = "NSG 생성 여부"
  type        = bool
  default     = true
}

variable "nsg_rules" {
  description = "NSG 규칙 목록(선택)"
  type = list(object({
    name                         = string
    priority                     = number
    direction                    = string   # Inbound / Outbound
    access                       = string   # Allow / Deny
    protocol                     = string   # Tcp/Udp/Asterisk
    source_port_range            = optional(string)
    destination_port_range       = optional(string)
    source_port_ranges           = optional(list(string))
    destination_port_ranges      = optional(list(string))
    source_address_prefix        = optional(string)
    destination_address_prefix   = optional(string)
    source_address_prefixes      = optional(list(string))
    destination_address_prefixes = optional(list(string))
  }))
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
