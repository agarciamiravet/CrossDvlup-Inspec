terraform {
  backend "azurerm" {
    resource_group_name  = "rg-crossdvlup-inspec"
    storage_account_name = "storcrossdvlupinspec"
    container_name       = "terraform-backend"
    key                  = "terraform-crossdvlup.tfstate"
  }
}