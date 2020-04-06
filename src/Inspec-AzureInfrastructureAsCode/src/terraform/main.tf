locals {
  location             = "West Europe"
  environment          = "production"
  database_server_tags = var.tags
  externalIp           = split(",", azurerm_app_service.pasionporlosbits_webapp.outbound_ip_addresses)
}

resource "azurerm_resource_group" "CharlaResourceGroup" {
  name     = "rg-crossdvlp-inspec"
  location = local.location
}