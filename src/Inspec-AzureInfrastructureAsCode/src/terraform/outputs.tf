output "resource_group_name" {
  value = azurerm_resource_group.CharlaResourceGroup.name
}

output "database_server_name" {
  value = azurerm_sql_server.DatabaseServerPasionPorLosBits.name
}

output "sql_database_name" {
  value = azurerm_sql_database.DatabaseInstancePasionPorLosBits.name
}

output "web_name" {
  value = azurerm_app_service.pasionporlosbits_webapp.name
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "storage_container_name" {
  value = azurerm_storage_container.storage-container.name
}