resource "azurerm_storage_account" "storage" {
  name                     = "storpassionporlosbits"
  resource_group_name      = azurerm_resource_group.CharlaResourceGroup.name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  enable_https_traffic_only = true
}

resource "azurerm_storage_container" "storage-container" {
  name                  = "images"
  resource_group_name   = azurerm_resource_group.CharlaResourceGroup.name
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}