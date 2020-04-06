resource "azurerm_app_service_plan" "pasionporlosbits_serviceplan" {
  name                = "appsvc-pasionporlosbits"
  location            = local.location
  resource_group_name = azurerm_resource_group.CharlaResourceGroup.name

  sku {
    tier = var.serviceplan_sku_tier
    size = var.serviceplan_sku_size
  }

  tags = local.database_server_tags
}

resource "azurerm_app_service" "pasionporlosbits_webapp" {
  name                = var.webapp_url_site
  location            = local.location
  resource_group_name = azurerm_resource_group.CharlaResourceGroup.name
  app_service_plan_id = azurerm_app_service_plan.pasionporlosbits_serviceplan.id
  https_only          = var.webapp_enablehttps

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
    default_documents        = ["hostingstart.html"]
    http2_enabled            = true
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=tcp:${azurerm_sql_server.DatabaseServerPasionPorLosBits.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_sql_database.DatabaseInstancePasionPorLosBits.name};Persist Security Info=False;User ID=${azurerm_sql_server.DatabaseServerPasionPorLosBits.administrator_login};Password=${azurerm_sql_server.DatabaseServerPasionPorLosBits.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  }

  tags = local.database_server_tags
}

#certificate

resource "azurerm_app_service_certificate" "pasionporlosbits_certificate" {
  name                = "pasionporlosbits-certificate"
  resource_group_name = azurerm_resource_group.CharlaResourceGroup.name
  location            = local.location
  pfx_blob            = var.cert_pfx_base64
  password            = var.cert_pfx_password

  depends_on = [azurerm_app_service.pasionporlosbits_webapp]
}