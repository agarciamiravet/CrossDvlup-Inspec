#Database

resource "azurerm_sql_server" "DatabaseServerPasionPorLosBits" {
  name                         = "pasionporlosbitsdbserver"
  resource_group_name          = azurerm_resource_group.CharlaResourceGroup.name
  location                     = local.location
  version                      = "12.0"
  administrator_login          = "mradministrator"
  administrator_login_password = "thisIsDog11"

  tags = local.database_server_tags
}

resource "azurerm_sql_database" "DatabaseInstancePasionPorLosBits" {
  name                = "pasionporlosbitsdatabase"
  resource_group_name = azurerm_resource_group.CharlaResourceGroup.name
  location            = local.location
  server_name         = azurerm_sql_server.DatabaseServerPasionPorLosBits.name
  edition             = var.sqlserver_edition

  tags = local.database_server_tags

}