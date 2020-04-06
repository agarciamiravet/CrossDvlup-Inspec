variable "tags" {
  type        = map
  description = "Default tags for all resources"

  default = {
    Created_Modified_By = "terraform",
    Environment         = "production",
    Version             = "0.0.1"
  }
}

variable "sqlserver_edition" {
  type = string
}

variable "serviceplan_sku_tier" {
  type = string
}

variable "serviceplan_sku_size" {
  type = string
}

variable "webapp_url_site" {
  type = string
}

variable "webapp_enablehttps" {
  type    = bool
  default = true
}

variable "dns_simple_domain" {
  type = string
}

variable "url_site" {
  type = string
}

variable "cert_pfx_password" {
  type = string
}

variable "cert_pfx_base64" {
  type = string
}

variable "cert_thumbprint" {
  type = string
}

variable "webapp_azure_url_site" {
  type = string
}