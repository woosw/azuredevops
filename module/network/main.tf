resource "azurerm_virtual_network" "this" {
  name                = var.name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_servers         = var.dns_servers
  tags                = var.tags
}

# 서브넷 생성
resource "azurerm_subnet" "this" {
  for_each             = { for s in var.subnets : s.name => s }
  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes
  
  # 설정 옵션
  private_endpoint_network_policies             = lookup(each.value, "private_endpoint_network_policies", true)
  private_endpoint_network_policies_enabled     = lookup(each.value, "private_endpoint_network_policies_enabled", true)
  private_link_service_network_policies_enabled = try(each.value.private_link_service_network_policies_enabled, true)

  # (선택) Delegation
  dynamic "delegation" {
    for_each = try(each.value.delegations, [])
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_name
        actions = try(delegation.value.actions, null)
      }
    }
  }
}

# (선택) NSG 생성
resource "azurerm_network_security_group" "this" {
  count               = var.create_nsg ? 1 : 0
  name                = "${var.name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# (선택) NSG 규칙
resource "azurerm_network_security_rule" "rules" {
  for_each = var.create_nsg ? { for r in var.nsg_rules : r.name => r } : {}
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = try(each.value.source_port_range, null)
  destination_port_range      = try(each.value.destination_port_range, null)
  source_port_ranges          = try(each.value.source_port_ranges, null)
  destination_port_ranges     = try(each.value.destination_port_ranges, null)
  source_address_prefix       = try(each.value.source_address_prefix, null)
  destination_address_prefix  = try(each.value.destination_address_prefix, null)
  source_address_prefixes     = try(each.value.source_address_prefixes, null)
  destination_address_prefixes= try(each.value.destination_address_prefixes, null)
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this[0].name
}

# (선택) 서브넷-NSG 연결
resource "azurerm_subnet_network_security_group_association" "assoc" {
  for_each = var.create_nsg ? { for s in var.subnets : s.name => s if try(s.attach_nsg, false) } : {}
  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.this[0].id
}
