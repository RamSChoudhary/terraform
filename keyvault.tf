data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "test-rg" {
  name     = "test-rg"
  location = "eastus"
}

resource "azurerm_key_vault" "test-kv" {
  name                        = "test-kv1441"
  location                    = azurerm_resource_group.test-rg.location
  resource_group_name         = azurerm_resource_group.test-rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}
