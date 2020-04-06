resource "dnsimple_record" "simpledns_pasionporlosbits_record" {
  domain = var.dns_simple_domain
  name   = ""
  value  = element(local.externalIp, 0)
  type   = "A"
  ttl    = 3600
}

resource "dnsimple_record" "simpledns_pasionporlosbits_record_cname" {
  domain = var.dns_simple_domain
  name   = "www"
  value  = var.webapp_azure_url_site
  type   = "CNAME"
  ttl    = 60
}

resource "azurerm_app_service_custom_hostname_binding" "pasionporlosbits_binding_dns" {
  hostname            = var.url_site
  app_service_name    = azurerm_app_service.pasionporlosbits_webapp.name
  resource_group_name = azurerm_resource_group.CharlaResourceGroup.name
  ssl_state           = "SniEnabled"
  thumbprint          = var.cert_thumbprint

  depends_on = [dnsimple_record.simpledns_pasionporlosbits_record,dnsimple_record.simpledns_pasionporlosbits_record_cname]
}