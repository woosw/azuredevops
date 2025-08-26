resource "azurerm_resource_group" "az_rg" {
  name     = var.name
  location = var.location
  tags     = var.tags
}

# (선택) 삭제 방지 락
resource "azurerm_management_lock" "rg_lock" {
  count      = var.enable_lock ? 1 : 0
  name       = var.lock_name != null ? var.lock_name : "${azurerm_resource_group.this.name}-lock"
  scope      = azurerm_resource_group.this.id
  lock_level = var.lock_level # "CanNotDelete" or "ReadOnly"
  notes      = var.lock_notes
}